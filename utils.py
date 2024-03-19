import requests
import sqlite3
import os

api_key = os.environ.get('OPENAI_API_KEY')


def make_request(api_endpoint, messages, model):
    parameters = {
        'messages': messages,
        'temperature': 0.6,
        'model': model,
        'stream': False,
    }

    headers = {
        "Content-Type": "application/json",
        'Authorization': "Bearer " + (api_key or '')
    }

    resp = requests.post(
        f'{api_endpoint}/v1/chat/completions',
        headers=headers,
        json=parameters,
    )

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
            code TEXT NOT NULL,
            finish_reason TEXT NOT NULL,
            content TEXT NOT NULL,
            reference TEXT,
            trial INTEGER NOT NULL,
            hash BLOB NOT NULL,
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
