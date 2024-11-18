# VulBench

This repository contains materials for the paper "How Far Have We Gone in Vulnerability Detection Using Large Language Model".

# Usage

Suppose there is OpenAI-compatiable endpoint at `http://localhost:8080`, you can use the following command to evaluate the model.

```bash
# Alternatively, set OPENAI_API_KEY environment variable
export OPENAI_API_KEY=xxx
python3 query.py \
  --datasets d2a ctf magma big-vul devign \
  --db_path ./query_result.db \
  --api_endpoint http://localhost:8080 \
  --model 'Llama-2-7b-chat-hf' \
  --trials 5 \
  --do_binary_classification \
  --do_multiple_classification \
  --concurrency 100
```

Specifically, it will query the model `Llama-2-7b-chat-hf` with the datasets `d2a`, `ctf`, `magma`, `big-vul`, and `devign`. The results will be stored in the SQLite database `query_result.db`. The script will run 5 trials for each dataset and the script will send 100 requests concurrently.

After that, evaluate the result database with the following command.

```bash
python3 eval.py ./query_result.db [./query_result_1.db, ./query_result_2.db, ...]
```

It will generate a `all_result.csv` file, containing the different metrics for each dataset with different prompt type.

# Extra Data

The compiled binaries (including fixed and unfixed, compiled with `-g -fno-inline-functions -O2` to better represent the original individual vulnerable functions) and source code (with `MAGMA_ENABLE_FIXES` and `MAGMA_ENABLE_CANARIES` left untouched) are available at [VulBench](https://cloud.vul337.team:8443/s/fKcarsnKocQqnkx).

# News
- [2023/12/18] We release the raw datasets of VulBench.
- [2024/3/19] We release the code for querying the model and evaluating the results.

# Bibtex
If this work is helpful for your research, please consider citing the following BibTeX entry.

```
@article{gao2023far,
  title={How Far Have We Gone in Vulnerability Detection Using Large Language Models},
  author={Gao, Zeyu and Wang, Hao and Zhou, Yuchen and Zhu, Wenyu and Zhang, Chao},
  journal={arXiv preprint arXiv:2311.12420},
  year={2023}
}
```

