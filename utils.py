import requests
import sqlite3
import json
import aiohttp


async def post_request(url, data):
    timeout = aiohttp.ClientTimeout(total=3 * 3600)
    headers = {"User-Agent": "Benchmark Client"}
    async with aiohttp.ClientSession(timeout=timeout) as session:
        async with session.post(url, headers=headers, json=data) as response:
            chunks = []
            async for chunk, _ in response.content.iter_chunks():
                chunks.append(chunk)
        output = b"".join(chunks).decode("utf-8")
        output = json.loads(output)

    return output


async def make_request(api_endpoint, messages, model):
    parameters = {
        'messages': messages,
        'temperature': 0.6,
        'model': model,
        'stream': False,
    }

    resp = await post_request(
        f'{api_endpoint}/v1/chat/completions', data=parameters)

    return resp.json()


def get_models(api_endpoint):
    resp = requests.get(f'{api_endpoint}/v1/models').json()
    return [m['id'] for m in resp['data']]


def open_db(db_name):
    db = sqlite3.connect(db_name)
    db.execute('''
        CREATE TABLE IF NOT EXISTS result (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            model TEXT NOT NULL,
            dataset TEXT NOT NULL,
            func_name TEXT,
            dataset_type TEXT NOT NULL,
            identifier TEXT NOT NULL,
            query_type TEXT NOT NULL,
            content TEXT NOT NULL,
            reference TEXT,
            trial INTEGER NOT NULL,
            prompt_type TEXT NOT NULL
        )
    ''')
    return db


def store_in_sqlite(
    db_path, **data
):
    db = open_db(db_path)
    store_in_sqlite_manual(db, **data)
    db.close()


def store_in_sqlite_manual(
    db, **data
):
    db_key = []
    db_value = []
    for k, v in data.items():
        db_key.append(k)
        db_value.append(v)

    db.execute('''
        INSERT INTO result ({db_key})
        VALUES ({place_holder})
    '''.format(
        db_key=', '.join(db_key),
        place_holder=', '.join(['?'] * len(db_key))
    ), db_value)
    db.commit()


def query_all_data_in_sqlite(db_path, columns):
    db = open_db(db_path)
    cursor = db.execute('''
        SELECT {} FROM result
    '''.format(', '.join(columns)))
    return cursor.fetchall()
