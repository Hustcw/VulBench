# %%

from utils import get_models, make_request, store_in_sqlite, query_all_data_in_sqlite
import datasets
import pandas as pd
from transformers import AutoTokenizer
import argparse
from concurrent.futures import ThreadPoolExecutor, as_completed
from tqdm.auto import tqdm
import json
import pathlib
import yaml
import re
from functools import partial
import hashlib

# %%

with open('./config.yaml', 'r') as f:
    config = yaml.safe_load(f)

# %%

parser = argparse.ArgumentParser()
parser.add_argument('datasets', type=str, nargs='+',
                    choices=config['dataset'].keys())
parser.add_argument('--model', type=str, default='')
parser.add_argument('--model_max_tokens', type=int, default=4096)
parser.add_argument('--concurrency', type=int, default=5)
parser.add_argument('--trials', type=int, default=1)
parser.add_argument('--db_path', type=str)
parser.add_argument('--do_description', action='store_true')
parser.add_argument('--do_binary_classification', action='store_true')
parser.add_argument('--do_multiple_classification', action='store_true')
parser.add_argument('--api_endpoint', type=str,
                    default='http://localhost:8080')

args, _ = parser.parse_known_args()

# %%

models = get_models(args.api_endpoint)

assert args.model in models, f'Unknown model: {args.model}, available models: {models}'

# %%

system_prompt = config['common']['system_prompt']
replace_place_holder = config['common']['replace']
replace_type_place_holder = config['common']['replace_type']

# %%

metadata_columns = [
    'dataset', 'model', 'dataset_type', 'identifier', 'func_name', 'query_type', 'trial', 'prompt_type',
]
pathlib.Path(args.db_path).parent.mkdir(parents=True, exist_ok=True)
conducted_queries = query_all_data_in_sqlite(args.db_path, metadata_columns)
conducted_queries = set([
    hashlib.md5('-'.join([
        str('' if x is None else x) for x in item
    ]).encode()).digest()
    for item in conducted_queries
])

# %%

exceed_length_message_pattern = re.compile(
    r"This model's maximum context length is (\d+) tokens. However, you requested (\d+) tokens")


def do_request(metadata, model, messages):
    resp = ''
    max_new_tokens = args.model_max_tokens
    try:
        while True:
            resp = make_request(args.api_endpoint, messages, model)
            if resp.get('object') == 'error' and resp['code'] == 40303:
                message = resp['message']
                pm = exceed_length_message_pattern.match(message)
                if pm:
                    model_max_length = int(pm.group(1))
                    requested_length = int(pm.group(2))
                    max_new_tokens -= requested_length - model_max_length
                    if max_new_tokens <= 0:
                        return None
                else:
                    raise ValueError(f'Unknown error message: {message}')
            else:
                break

        finish_reason = resp['choices'][0]['finish_reason']
        content = resp['choices'][0]['message']['content']
        if finish_reason != 'stop':
            raise ValueError(f'finish_reason: {finish_reason}')
        return (metadata, content)
    except Exception as e:
        # print(messages)
        print(f'make_request err: {e}, resp: {resp}')
        return None


def run(queries):
    with ThreadPoolExecutor(max_workers=args.concurrency) as executor:
        futures = []
        for query in queries:
            dataset_name = query['dataset']

            prompts = []
            if query['query_type'] in [
                    'multiple_classification_single_function',
                    'multiple_classification_all_function'
            ]:
                if not args.do_multiple_classification:
                    continue

                for prompt_type, data in config['common']['multiple_classification_prompt'].items():
                    messages = [
                        {'role': 'system', 'content': system_prompt},
                        *data['few_shot_examples'],
                        {'role': 'user', 'content': data['prompt_template'].replace(
                            replace_place_holder, query['code']).replace(
                            replace_type_place_holder, config['dataset'][dataset_name]['type_to_replace'])}
                    ]

                    prompts.append((prompt_type, messages))

                reference = query['type']
            elif query['query_type'] in [
                'binary_classification_single_function',
            ]:
                if not args.do_binary_classification:
                    continue
                for prompt_type, data in config['common']['binary_classification_prompt'].items():
                    messages = [
                        {'role': 'system', 'content': system_prompt},
                        *data['few_shot_examples'],
                        {'role': 'user', 'content': data['prompt_template'].replace(
                            replace_place_holder, query['code'])}
                    ]
                    prompts.append((prompt_type, messages))
                reference = query['label']
            elif query['query_type'] in [
                'description'
            ]:
                if not args.do_description:
                    continue
                for prompt_type, data in config['common']['description_prompt'].items():
                    messages = [
                        {'role': 'system', 'content': system_prompt},
                        *data['few_shot_examples'],
                        {'role': 'user', 'content': data['prompt_template'].replace(
                            replace_place_holder, query['code'])}
                    ]

                    prompts.append((prompt_type, messages))
                reference = query['description']
            else:
                raise ValueError(f'Unknown query_type: {query["query_type"]}')

            for i in range(args.trials):
                for prompt_type, messages in prompts:
                    metadata = {
                        k: v
                        for k, v in query.items() if k in metadata_columns
                    }
                    metadata['model'] = args.model
                    metadata['trial'] = i
                    metadata['prompt_type'] = prompt_type

                    metadata_hash = hashlib.md5('-'.join([
                        str('' if metadata.get(x) is None else metadata[x])
                        for x in metadata_columns
                    ]).encode()).digest()

                    if metadata_hash in conducted_queries:
                        # print(f'Already conducted: {metadata}')
                        continue
                    future = executor.submit(
                        do_request, {
                            **metadata,
                            'reference': json.dumps(reference),
                        }, args.model, messages)
                    futures.append(future)

        for result in tqdm(as_completed(futures), total=len(futures)):
            if result.exception():
                print(f'result exception: {result.exception()}')
                continue
            data = result.result()
            if data is None:
                continue
            metadata, content = data
            print(', '.join([f'{k}: {v}' for k, v in metadata.items()]))
            try:
                store_in_sqlite(args.db_path, **metadata, content=content)
            except IOError as e:
                print(f'store_in_sqlite err: {e}')
                continue

# %%


def prepare_ctf():
    # ctf_ds = datasets.load_from_disk('../cleaned_datasets/ctf')
    # ctf_ds = datasets.concatenate_datasets([
    #     ctf_ds['train'],
    #     ctf_ds['test'],
    # ])

    for ctf_challenge in pathlib.Path('data/ctf').iterdir():
        meta_data = json.loads((ctf_challenge / 'meta_data.json').read_text())
        full_context = (ctf_challenge / 'full_context.c').read_text()

        full_ida_decompile_code = meta_data['global_variables_ida'] + '\n'

        exists_vul_type = [
            x.strip() for x in meta_data['vulnerability_type'].split(',')]

        for reversed_function in (ctf_challenge / 'reversed_functions').iterdir():
            func_name = reversed_function.stem
            function_content = (reversed_function / 'decompile.c').read_text()
            function_metadata = json.loads(
                (reversed_function / 'meta_data.json').read_text())

            metadata = {
                'dataset': 'ctf',
                'dataset_type': 'ctf_reversed',
                'func_name': func_name,
                'identifier': row['identifier'],
                'code': gv_manual + '\n' + content['decompile_code'],
            }

    queries = []
    for row in ctf_ds:
        # Maunally reversed
        gv_manual = row['gv_manual']
        gv_ida = row['gv_ida']
        full_ida_decompile_code = gv_ida + '\n'
        exists_vul_type = [x.strip() for x in row['type'].split(',')]
        if row['r_functions']:
            for func_name, content in json.loads(row['r_functions']).items():
                metadata = {
                    'dataset': 'ctf',
                    'dataset_type': 'ctf_reversed',
                    'func_name': func_name,
                    'identifier': row['identifier'],
                    'code': gv_manual + '\n' + content['decompile_code'],
                }

                # Single Function, Multiple Classification
                queries.append({
                    **metadata,
                    'type': exists_vul_type if content['label'] else [],
                    'query_type': 'multiple_classification_single_function',
                })

                # Single Function, Binary Classification
                queries.append({
                    **metadata,
                    'label': content['label'],
                    'query_type': 'binary_classification_single_function',
                })

        if row['functions']:
            for func_name, content in json.loads(row['functions']).items():
                full_ida_decompile_code += content['decompile_code'] + '\n'

                metadata = {
                    'dataset': 'ctf',
                    'dataset_type': 'ctf_ida',
                    'func_name': func_name,
                    'identifier': row['identifier'],
                    'code': gv_ida + '\n' + content['decompile_code'],
                }

                queries.append({
                    **metadata,
                    'type': exists_vul_type if content['label'] else [],
                    'query_type': 'multiple_classification_single_function',
                })

                queries.append({
                    **metadata,
                    'label': content['label'],
                    'query_type': 'binary_classification_single_function',
                })

        queries.append({
            'dataset': 'ctf',
            'dataset_type': 'ctf_ida',
            'identifier': row['identifier'],
            'type': exists_vul_type,
            'code': full_ida_decompile_code,
            'query_type': 'multiple_classification_all_function',
        })

        ctf_reversed_metadata = {
            'dataset': 'ctf',
            'dataset_type': 'ctf_reversed',
            'identifier': row['identifier'],
            'code': row['all_functions'],
        }
        queries.append({
            **ctf_reversed_metadata,
            'description': row['root_cause'],
            'query_type': 'description',
        })
        queries.append({
            **ctf_reversed_metadata,
            'type': exists_vul_type,
            'query_type': 'multiple_classification_all_function',
        })
    return queries

# %%


def prepare_magma():
    magma_ds = datasets.load_from_disk('../cleaned_datasets/magma')
    magma_ds = datasets.concatenate_datasets(
        [magma_ds['train'], magma_ds['test']])

    queries = []

    for row in magma_ds:
        exists_vul_type = [x.strip() for x in row['type'].split(',')]
        if row['src_functions']:
            for content in json.loads(row['src_functions']):
                metadata = {
                    'dataset': 'magma',
                    'dataset_type': 'magma_src',
                    'func_name': content['func_name'],
                    'identifier': row['identifier'],
                    'code': content['source_code'],
                }

                if exists_vul_type:
                    queries.append({
                        **metadata,
                        'type': exists_vul_type if content['label'] else [],
                        'query_type': 'multiple_classification_single_function',
                    })

                queries.append({
                    **metadata,
                    'label': content['label'],
                    'query_type': 'binary_classification_single_function',
                })

        if row['bin_functions']:
            for content in json.loads(row['bin_functions']):
                metadata = {
                    'dataset': 'magma',
                    'dataset_type': 'magma_bin',
                    'func_name': content['func_name'],
                    'identifier': row['identifier'],
                    'code': content['decompile_code'],
                }

                if exists_vul_type:
                    queries.append({
                        **metadata,
                        'type': exists_vul_type if content['label'] else [],
                        'query_type': 'multiple_classification_single_function',
                    })

                queries.append({
                    **metadata,
                    'label': content['label'],
                    'query_type': 'binary_classification_single_function',
                })

        magma_src_metadata = {
            'dataset': 'magma',
            'dataset_type': 'magma_src',
            'identifier': row['identifier'],
        }
        magma_bin_metadata = {
            'dataset': 'magma',
            'dataset_type': 'magma_bin',
            'identifier': row['identifier'],
        }
        if exists_vul_type:
            queries.append({
                **magma_src_metadata,
                'type': exists_vul_type,
                'code': row['unfix_all_functions'],
                'query_type': 'multiple_classification_all_function',
            })
            queries.append({
                **magma_src_metadata,
                'type': [],
                'code': row['fix_all_functions'],
                'query_type': 'multiple_classification_all_function',
            })
            queries.append({
                **magma_bin_metadata,
                'type': exists_vul_type,
                'code': row['bin_unfix_all_functions'],
                'query_type': 'multiple_classification_all_function',
            })
            queries.append({
                **magma_bin_metadata,
                'type': [],
                'code': row['bin_fix_all_functions'],
                'query_type': 'multiple_classification_all_function',
            })

        if row['root_cause']:
            queries.append({
                **magma_src_metadata,
                'description': row['root_cause'],
                'code': row['unfix_all_functions'],
                'query_type': 'description',
            })
    return queries


# %%


def prepare_suvery(dataset_name):
    queries = []
    ds = datasets.load_from_disk(f'../cleaned_datasets/{dataset_name}')
    ds = datasets.concatenate_datasets([
        ds['train'],
        ds['test'],
    ])
    for row in ds:
        metadata = {
            'dataset': dataset_name,
            'dataset_type': dataset_name,
            'identifier': row['identifier'],
            'code': row['function'],
        }
        if row['type']:
            vul_type = [x.strip() for x in row['type'].split(',')]
            queries.append({
                **metadata,
                'type': vul_type if row['vulnerable'] else [],
                'query_type': 'multiple_classification_single_function',
            })
        elif row['vulnerable'] is False:
            queries.append({
                **metadata,
                'type': [],
                'query_type': 'multiple_classification_single_function',
            })

        queries.append({
            **metadata,
            'label': row['vulnerable'],
            'query_type': 'binary_classification_single_function',
        })
    return queries


# %%
# %%
prepare_function = {
    'ctf': prepare_ctf,
    'magma': prepare_magma,
    'big-vul': partial(prepare_suvery, dataset_name='big-vul'),
    'devign': partial(prepare_suvery, dataset_name='devign'),
    'd2a': partial(prepare_suvery, dataset_name='d2a'),
}

for dataset in args.datasets:
    queries = prepare_function[dataset]()
    run(queries)
