# %%

import pathlib
import json

# %%

for full_context_path in pathlib.Path('data/ctf').rglob('**/full_context.c'):
    full_context = full_context_path.read_text()
    metadata = json.loads(
        (full_context_path.parent / 'meta_data.json').read_text())

    global_variables_manual = metadata['global_variables_manual']
    first_occur = full_context.find(global_variables_manual)
    if first_occur < 0 or first_occur > 5:
        continue
    second_occur = full_context.find(
        global_variables_manual, first_occur + len(global_variables_manual))
    if second_occur < 0 or second_occur - (first_occur + len(global_variables_manual)) > 5:
        continue

    full_context = full_context[:second_occur]
    full_context = full_context.strip()
    full_context_path.write_text(full_context)
