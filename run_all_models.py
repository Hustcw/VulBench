# %%

import subprocess
import yaml
import subprocess
import argparse
import threading
import os

# %%

parser = argparse.ArgumentParser()
parser.add_argument('--save_path', default='eval')
parser.add_argument('--trials', default=1, type=int)
parser.add_argument('--models', nargs='+', type=str, default=None)
parser.add_argument('--do_description', action='store_true')
parser.add_argument('--do_binary_classification', action='store_true')
parser.add_argument('--do_multiple_classification', action='store_true')
parser.add_argument('--concurrency', default=10, type=int)
args = parser.parse_args()

# %%


def run_worker(model_name):
    concurrency = args.concurrency

    exp_to_conduct = ' '
    if args.do_binary_classification:
        exp_to_conduct += ' --do_binary_classification '
    if args.do_multiple_classification:
        exp_to_conduct += ' --do_multiple_classification '
    if args.do_description:
        exp_to_conduct += ' --do_description '

    cmd = f'''python3 query.py \
        --concurrency {concurrency} --trials {args.trials} \
        --db_path {args.save_path}/{model_name}.db \
        --api_endpoint http://localhost:8080 \
        --model "{model_name}" \
        {exp_to_conduct} \
        d2a ctf magma big-vul devign'''

    with open(f'{args.save_path}/{model_name}.log', 'a+') as f, \
            open(f'{args.save_path}/{model_name}.stderr', 'a+') as ferr:
        subprocess.run(
            cmd, shell=True,
            stdout=f, stderr=ferr
        )


models = args.models

os.makedirs(args.save_path, exist_ok=True)

threads = []

for model_name in models:
    print(model_name)

    t = threading.Thread(target=run_worker, args=(model_name, ))
    threads.append(t)


for t in threads:
    t.start()

for t in threads:
    t.join()
