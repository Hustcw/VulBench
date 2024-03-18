from sklearn.metrics import accuracy_score, precision_recall_fscore_support, confusion_matrix
import json
import re
import pandas as pd
from utils import query_all_data_in_sqlite
import argparse
import os

parser = argparse.ArgumentParser()
parser.add_argument('db_path', nargs='+')

args = parser.parse_args()

db_path = args.db_path


def get_parsed_data(db_path):
    print(db_path)
    columns = [
        'dataset', 'model', 'dataset_type', 'func_name', 'identifier',
        'query_type', 'prompt_type', 'content', 'reference', 'trial'
    ]

    all_data = query_all_data_in_sqlite(
        db_path,
        columns
    )
    parsed = []
    for row in all_data:
        parsed.append({
            k: v for k, v in zip(columns, row)
        })
    return parsed


all_data = []

for db in db_path:
    all_data += get_parsed_data(db)

all_data = pd.DataFrame(all_data)


def binary_classfication_eval(model_df, dataset_name, prompt_type, dataset_type, query_type):
    model_df = model_df[
        (model_df['dataset'] == dataset_name)
        & (model_df['prompt_type'] == prompt_type)
        & (model_df['dataset_type'] == dataset_type)
        & (model_df['query_type'] == query_type)
    ]

    binary_list = [
        (item['content'], item['reference'])
        for _, item in model_df.iterrows()
    ]
    predictions = [
        "VULNERABLE: YES".lower() in item[0].lower() for item in binary_list
    ]
    labels = [json.loads(item[1]) for item in binary_list]
    precision, recall, f1, _ = precision_recall_fscore_support(
        labels, predictions, average='binary')
    acc = accuracy_score(labels, predictions)
    return {
        'acc': acc,
        'f1': f1,
        'precision': precision,
        'recall': recall
    }


dataset_label_map = {
    'd2a': ['Null-Pointer-Dereference', 'Integer-Overflow', 'Resource-Exhaustion-Error', 'Buffer-Overflow'],
    'ctf': ['Use-After-Free', 'Integer-Overflow', 'Format-String-Vulnerability', 'Type-Confusion', 'Buffer-Overflow'],
    'magma': ['Null-Pointer-Dereference', 'Buffer-Overflow', 'Memory-Leak', 'Use-After-Free', 'Integer-Overflow', 'Type-Confusion', 'Divede-by-Zero', 'Math-Error', 'Resource-Exhaustion-Error', 'Lack-of-Error-Handling'],
    'big-vul': ['Null-Pointer-Dereference', 'Memory-Leak', 'Use-After-Free', 'Integer-Overflow', 'Improper-Access-Control', 'Race-Condition', 'Buffer-Overflow', 'Resource-Exhaustion-Error', 'Math-Error'],
    'devign': ['Null-Pointer-Dereference', 'Memory-Leak', 'Lack-Sanity-Check', 'Integer-Overflow', 'Divede-by-Zero', 'Race-Condition', 'Buffer-Overflow'],
}

dataset_regx_map = {}
for dataset in dataset_label_map.keys():
    labels = dataset_label_map[dataset] + ['No-Vulnerability']
    idx_list = []
    dataset_regx_map[dataset] = r'(TYPE:|Type:|type:|\d\.)\s?(' + \
        r'|'.join(labels) + r')'


def find_match(text, regx):
    matches = re.findall(regx, text)
    if len(matches) != 0:
        return matches[-1][1]  # Take the last one
    return 'Invalid'


def multi_classification_eval(model_df, dataset_name, prompt_type, dataset_type, query_type, filename='debug.log'):
    dataset_filter = model_df[
        (model_df['dataset'] == dataset_name)
        & (model_df['prompt_type'] == prompt_type)
        & (model_df['dataset_type'] == dataset_type)
        & (model_df['query_type'] == query_type)
    ]

    predictions = []
    labels = []
    with open(filename, 'w') as f:
        for _, item in dataset_filter.iterrows():
            predict = find_match(
                item['content'], dataset_regx_map[dataset_name])
            reference_list = json.loads(item['reference'])
            if len(reference_list) == 0:
                reference_list = ['No-Vulnerability']

            if predict in reference_list:
                predictions.append(predict)
                labels.append(predict)
                print(
                    f"[SUCCESS]: {predict}\nreference: {reference_list}\ncontent: {item['content']}\n\n", file=f)
            else:
                predictions.append(predict)
                labels.append(reference_list[-1])
                print(
                    f"[FAILED]: {predict}\nreference: {reference_list}\ncontent: {item['content']}\n\n", file=f)

    all_label_list = list(set(labels))
    num_labels = len(all_label_list)
    acc = accuracy_score(labels, predictions)
    precision, recall, f1, _ = precision_recall_fscore_support(
        labels, predictions, average='macro', labels=all_label_list)

    if num_labels < 2:
        cm = [[]]
    else:
        cm = confusion_matrix(labels, predictions,
                              labels=all_label_list+['Invalid'])
    if not isinstance(cm, list):
        cm = cm.tolist()

    if num_labels < 3:
        acc = 0
        f1 = 0
        precision = 0
        recall = 0

    predcition_result = {
        'acc': acc,
        'f1': f1,
        'precision': precision,
        'recall': recall,
        'cm': cm
    }
    return predcition_result


final_results = {
    'model': [],
    'query_type': [],
    'dataset_name': [],
    'dataset_type': [],
    'prompt_type': [],
    'acc': [],
    'f1': [],
    'precision': [],
    'recall': [],
    'cm': []
}

dataset_type_map = {
    'ctf': ['ctf_ida', 'ctf_reversed'],
    'magma': ['magma_bin', 'magma_src'],
    'big-vul': ['big-vul'],
    'd2a': ['d2a'],
    'devign': ['devign']
}

os.makedirs('./debug/', exist_ok=True)

for model, model_data in all_data.groupby('model'):
    for query_type in ['binary_classification_single_function', 'multiple_classification_single_function', 'multiple_classification_all_function']:
        for dataset_name in ['big-vul', 'ctf', 'd2a', 'devign', 'magma']:
            for dataset_type in dataset_type_map[dataset_name]:
                for prompt_type in ['2_shot', '5_shot']:
                    final_results['model'].append(model)
                    final_results['query_type'].append(query_type)
                    if query_type == 'binary_classification_single_function':
                        result = binary_classfication_eval(
                            model_data, dataset_name, prompt_type, dataset_type, query_type)
                    else:
                        result = multi_classification_eval(model_data, dataset_name, prompt_type, dataset_type,
                                                           query_type, filename=f"./debug/{model}-{dataset_type}-{prompt_type}-{query_type}.log")
                        if model in ['falcon-40b-instruct', 'vicuna-33b-v1.3'] and prompt_type == '5_shot':
                            result = {
                                'acc': 0,
                                'f1': 0,
                                'precision': 0,
                                'recall': 0,
                                'cm': [[]]
                            }
                    final_results['dataset_name'].append(dataset_name)
                    final_results['dataset_type'].append(dataset_type)
                    final_results['prompt_type'].append(prompt_type)
                    final_results['acc'].append(result['acc'])
                    final_results['f1'].append(result['f1'])
                    final_results['precision'].append(result['precision'])
                    final_results['recall'].append(result['recall'])
                    if query_type != 'binary_classification_single_function':
                        final_results['cm'].append(json.dumps(result['cm']))
                    else:
                        final_results['cm'].append('')


new_df = pd.DataFrame(final_results)
new_df.to_csv('all_result.csv', index=False)
