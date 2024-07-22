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

metadata_column = [
    'model',
    'dataset',
    'func_name',
    'dataset_type',
    'identifier',
    'query_type',
    'code',
    'reference',
    'trial',
    'hash',
    'prompt_type',
]

pathlib.Path(args.db_path).parent.mkdir(parents=True, exist_ok=True)
conducted_queries = query_all_data_in_sqlite(args.db_path, ['hash'])
conducted_queries = set([
    item[0] for item in conducted_queries
])

# %%

exceed_length_message_pattern = re.compile(
    r"This model's maximum context length is (\d+) tokens. However, your messages resulted in (\d+) tokens. Please reduce the length of the messages."
)


def do_request(metadata, model, messages):
    resp = ''
    try:
        while True:
            resp = make_request(args.api_endpoint, messages, model)
            if resp.get('object') == 'error' and resp['code'] == 40303:
                message = resp['message']
                pm = exceed_length_message_pattern.match(message)
                if pm:
                    model_max_length = int(pm.group(1))
                    requested_length = int(pm.group(2))
                    max_new_tokens = requested_length - model_max_length
                    if max_new_tokens <= 0:
                        return None
                else:
                    raise ValueError(f'Unknown error message: {message}')
            else:
                break

        finish_reason = resp['choices'][0]['finish_reason']
        content = resp['choices'][0]['message']['content']
        return (metadata, finish_reason, content)
    except Exception as e:
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
                        k: v for k, v in query.items() if k in metadata_column
                    }

                    metadata.update({
                        'model': args.model,
                        'trial': i,
                        'prompt_type': prompt_type,
                        'reference': json.dumps(reference),
                    })

                    metadata_hash = hashlib.md5(json.dumps(
                        metadata, sort_keys=True).encode()).digest()

                    if metadata_hash in conducted_queries:
                        continue
                    future = executor.submit(
                        do_request, {**metadata, 'hash': metadata_hash}, args.model, messages)
                    futures.append(future)

        for result in tqdm(as_completed(futures), total=len(futures)):
            if result.exception():
                tqdm.write(f'result exception: {result.exception()}')
                continue
            data = result.result()
            if data is None:
                continue
            metadata, finish_reason, content = data
            tqdm.write(
                ', '.join([f'{k}: {v}' for k, v in metadata.items() if k not in ('code', 'hash')]))
            try:
                store_in_sqlite(args.db_path, **metadata,
                                content=content, finish_reason=finish_reason)
            except IOError as e:
                tqdm.write(f'store_in_sqlite err: {e}')
                continue

# %%


def prepare_ctf():
    queries = []
    for ctf_challenge in pathlib.Path('data/ctf').iterdir():
        # Maunally reversed
        identifier = ctf_challenge.stem
        challenge_metadata = json.loads(
            (ctf_challenge / 'meta_data.json').read_text())
        full_context = (ctf_challenge / 'full_context.c').read_text()
        gv_manual = challenge_metadata['global_variables_manual']
        gv_ida = challenge_metadata['global_variables_ida']
        full_ida_decompile_code = gv_ida + '\n'
        exists_vul_type = [x.strip()
                           for x in challenge_metadata['vulnerability_type']]
        assert exists_vul_type, f'No vulnerability type for {identifier}'
        if (ctf_challenge / 'reversed_functions').exists():
            for reversed_function in (ctf_challenge / 'reversed_functions').iterdir():
                func_name = reversed_function.stem
                function_content = (
                    reversed_function / 'decompile.c').read_text()
                function_metadata = json.loads(
                    (reversed_function / 'meta_data.json').read_text())
                query_metadata = {
                    'dataset': 'ctf',
                    'dataset_type': 'ctf_reversed',
                    'func_name': func_name,
                    'identifier': identifier,
                    'code': gv_manual + '\n' + function_content,
                }

                # Single Function, Multiple Classification
                queries.append({
                    **query_metadata,
                    'type': exists_vul_type if function_metadata['vulnerable'] else [],
                    'query_type': 'multiple_classification_single_function',
                })

                # Single Function, Binary Classification
                queries.append({
                    **query_metadata,
                    'label': function_metadata['vulnerable'],
                    'query_type': 'binary_classification_single_function',
                })

        if (ctf_challenge / 'functions').exists():
            for function in (ctf_challenge / 'functions').iterdir():
                func_name = function.stem
                function_content = (function / 'decompile.c').read_text()
                function_metadata = json.loads(
                    (function / 'meta_data.json').read_text())
                full_ida_decompile_code += function_content + '\n'

                query_metadata = {
                    'dataset': 'ctf',
                    'dataset_type': 'ctf_ida',
                    'func_name': func_name,
                    'identifier': identifier,
                    'code': gv_ida + '\n' + function_content,
                }

                queries.append({
                    **query_metadata,
                    'type': exists_vul_type if function_metadata['vulnerable'] else [],
                    'query_type': 'multiple_classification_single_function',
                })

                queries.append({
                    **query_metadata,
                    'label': function_metadata['vulnerable'],
                    'query_type': 'binary_classification_single_function',
                })

        queries.append({
            'dataset': 'ctf',
            'dataset_type': 'ctf_ida',
            'identifier': identifier,
            'type': exists_vul_type,
            'code': full_ida_decompile_code,
            'query_type': 'multiple_classification_all_function',
        })
        queries.append({
            'dataset': 'ctf',
            'dataset_type': 'ctf_reversed',
            'identifier': identifier,
            'code': full_context,
            'type': exists_vul_type,
            'query_type': 'multiple_classification_all_function',
        })

    return queries

# %%


def prepare_magma():
    queries = []

    for magma_challenge in pathlib.Path('data/magma').iterdir():
        identifier = magma_challenge.stem
        magma_metadata = json.loads(
            (magma_challenge / 'meta_data.json').read_text())
        exists_vul_type = [
            x.strip()
            for x in magma_metadata['vulnerability_type']
        ]

        has_seperate_functions = False

        if (magma_challenge / 'functions').exists():
            for function in (magma_challenge / 'functions').iterdir():
                func_name = function.stem[-1]
                source_code = (function / 'code.c').read_text()
                magma_function_metadata = json.loads(
                    (function / 'meta_data.json').read_text())

                metadata = {
                    'dataset': 'magma',
                    'dataset_type': 'magma_src',
                    'func_name': func_name,
                    'identifier': identifier,
                    'code': source_code,
                }

                if exists_vul_type:
                    queries.append({
                        **metadata,
                        'type': exists_vul_type if magma_function_metadata['vulnerable'] else [],
                        'query_type': 'multiple_classification_single_function',
                    })

                queries.append({
                    **metadata,
                    'label': magma_function_metadata['vulnerable'],
                    'query_type': 'binary_classification_single_function',
                })
            has_seperate_functions = True

        if (magma_challenge / 'bin_functions').exists():
            for function in (magma_challenge / 'bin_functions').iterdir():
                func_name = function.stem[-1]
                decompile_code = (function / 'code.c').read_text()
                magma_function_metadata = json.loads(
                    (function / 'meta_data.json').read_text())

                metadata = {
                    'dataset': 'magma',
                    'dataset_type': 'magma_bin',
                    'func_name': func_name,
                    'identifier': identifier,
                    'code': decompile_code,
                }

                if exists_vul_type:
                    queries.append({
                        **metadata,
                        'type': exists_vul_type if magma_function_metadata['vulnerable'] else [],
                        'query_type': 'multiple_classification_single_function',
                    })

                queries.append({
                    **metadata,
                    'label': magma_function_metadata['vulnerable'],
                    'query_type': 'binary_classification_single_function',
                })
            has_seperate_functions = True

        def try_read(path):
            return path.read_text() if path.exists() else None

        src_vuln = (magma_challenge / 'src_vulnerable.c').read_text()
        src_fixed = (magma_challenge / 'src_fixed.c').read_text()
        decompile_vuln = try_read(magma_challenge / 'decompile_vulnerable.c')
        decompile_fixed = try_read(magma_challenge / 'decompile_fixed.c')
        context = try_read(magma_challenge / 'context.c')
        context_decompile = try_read(magma_challenge / 'context_decompile.c')

        magma_src_metadata = {
            'dataset': 'magma',
            'dataset_type': 'magma_src',
            'identifier': identifier,
        }
        magma_bin_metadata = {
            'dataset': 'magma',
            'dataset_type': 'magma_bin',
            'identifier': identifier,
        }

        if not has_seperate_functions:
            if exists_vul_type:
                queries.append({
                    **magma_src_metadata,
                    'type': [],
                    'code': src_fixed,
                    'query_type': 'multiple_classification_single_function',
                })
            queries.append({
                **magma_src_metadata,
                'label': False,
                'code': src_fixed,
                'query_type': 'binary_classification_single_function',
            })

            if exists_vul_type:
                queries.append({
                    **magma_src_metadata,
                    'type': exists_vul_type,
                    'code': src_vuln,
                    'query_type': 'multiple_classification_single_function',
                })
            queries.append({
                **magma_src_metadata,
                'label': True,
                'code': src_vuln,
                'query_type': 'binary_classification_single_function',
            })

            if decompile_fixed:
                if exists_vul_type:
                    queries.append({
                        **magma_bin_metadata,
                        'type': [],
                        'code': decompile_fixed,
                        'query_type': 'multiple_classification_single_function',
                    })
                queries.append({
                    **magma_bin_metadata,
                    'label': False,
                    'code': decompile_fixed,
                    'query_type': 'binary_classification_single_function',
                })

            if decompile_vuln:
                if exists_vul_type:
                    queries.append({
                        **magma_bin_metadata,
                        'type': exists_vul_type,
                        'code': decompile_vuln,
                        'query_type': 'multiple_classification_single_function',
                    })
                queries.append({
                    **magma_bin_metadata,
                    'label': True,
                    'code': decompile_vuln,
                    'query_type': 'binary_classification_single_function',
                })

        if exists_vul_type:
            if context or has_seperate_functions:
                queries.append({
                    **magma_src_metadata,
                    'type': [],
                    'code': (context or '') + '\n' + src_fixed,
                    'query_type': 'multiple_classification_all_function',
                })
                queries.append({
                    **magma_src_metadata,
                    'type': exists_vul_type,
                    'code': (context or '') + '\n' + src_vuln,
                    'query_type': 'multiple_classification_all_function',
                })
            if context_decompile or has_seperate_functions:
                if decompile_fixed:
                    queries.append({
                        **magma_bin_metadata,
                        'type': [],
                        'code': (context_decompile or '') + '\n' + decompile_fixed,
                        'query_type': 'multiple_classification_all_function',
                    })
                if decompile_vuln:
                    queries.append({
                        **magma_bin_metadata,
                        'type': exists_vul_type,
                        'code': (context_decompile or '') + '\n' + decompile_vuln,
                        'query_type': 'multiple_classification_all_function',
                    })

    return queries


# %%


def prepare_suvery(dataset_name):

    queries = []
    for suvery_challenge in pathlib.Path(f'data/{dataset_name}').iterdir():
        code = (suvery_challenge / 'src.c').read_text()
        identifier = suvery_challenge.stem
        suvery_metadata = json.loads(
            (suvery_challenge / 'meta_data.json').read_text())
        metadata = {
            'dataset': dataset_name,
            'dataset_type': dataset_name,
            'identifier': identifier,
            'code': code,
        }
        if suvery_metadata['vulnerability_type']:
            vul_type = [x.strip()
                        for x in suvery_metadata['vulnerability_type']]
            queries.append({
                **metadata,
                'type': vul_type if suvery_metadata['vulnerable'] else [],
                'query_type': 'multiple_classification_single_function',
            })
        elif suvery_metadata['vulnerable'] is False:
            queries.append({
                **metadata,
                'type': [],
                'query_type': 'multiple_classification_single_function',
            })

        queries.append({
            **metadata,
            'label': suvery_metadata['vulnerable'],
            'query_type': 'binary_classification_single_function',
        })
    return queries


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
