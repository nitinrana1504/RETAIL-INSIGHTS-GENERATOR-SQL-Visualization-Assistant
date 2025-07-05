from sqlalchemy import create_engine, text
import pandas as pd
from config import DATABASE_URL, few_shots
from gemini_utils import generate_response

def get_table_info():
    info = ""
    engine = create_engine(DATABASE_URL)
    with engine.connect() as conn:
        tables = conn.execute(text("SHOW TABLES")).fetchall()
        for (table_name,) in tables:
            info += f"\n=== Table: {table_name} ===\n"
            desc = conn.execute(text(f"DESCRIBE {table_name}")).fetchall()
            for col in desc:
                info += f" - {col[0]} ({col[1]})\n"
    return info

def generate_sql_from_question(question, schema_info):
    examples = "\n".join([f"Question: {ex['Question']}\nSQLQuery: {ex['SQLQuery']}" for ex in few_shots])
    prompt = f"""
You are a MySQL expert. Given a question, generate a syntactically correct SQL query.

Schema:
{schema_info}

Examples:
{examples}

Now write an SQL query for:
Question: {question}
Only return the SQL query.
"""
    return generate_response(prompt)

def execute_query(sql):
    try:
        engine = create_engine(DATABASE_URL)
        with engine.connect() as conn:
            df = pd.read_sql(text(sql), conn)
        return df
    except Exception as e:
        return str(e)
