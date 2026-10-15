import re
import pandas as pd
import streamlit as st
from sqlalchemy import create_engine, text
from config import DATABASE_URL, few_shots
from gemini_utils import generate_response

FORBIDDEN_SQL_PATTERN = re.compile(
    r"\b(DROP|DELETE|UPDATE|INSERT|ALTER|TRUNCATE|CREATE|REPLACE|GRANT|REVOKE|"
    r"CALL|LOAD_FILE|OUTFILE|DUMPFILE|GET_LOCK|RELEASE_LOCK|SLEEP|BENCHMARK)\b",
    re.IGNORECASE,
)


@st.cache_resource
def get_engine():
    return create_engine(DATABASE_URL, pool_pre_ping=True)


@st.cache_data(ttl=600)
def get_table_info():
    info = ""
    engine = get_engine()
    with engine.connect() as conn:
        tables = conn.execute(text("SHOW TABLES")).fetchall()
        for (table_name,) in tables:
            # Quote identifiers returned by the database before using them.
            quoted_name = str(table_name).replace("`", "``")
            desc = conn.execute(text(f"DESCRIBE `{quoted_name}`")).fetchall()
            info += f"\n=== Table: {table_name} ===\n"
            for col in desc:
                info += f" - {col[0]} ({col[1]})\n"
    return info


def validate_readonly_sql(sql: str) -> str:
    if not isinstance(sql, str):
        raise ValueError("Generated SQL query is empty or invalid.")
    cleaned = sql.strip()
    # Permit one optional trailing semicolon, but reject statement chaining.
    if cleaned.endswith(";"):
        cleaned = cleaned[:-1].rstrip()
    if not cleaned:
        raise ValueError("Generated SQL query is empty.")
    if ";" in cleaned:
        raise ValueError("Multiple SQL statements are not allowed.")
    if "--" in cleaned or "/*" in cleaned or "*/" in cleaned or "#" in cleaned:
        raise ValueError("SQL comments are not allowed.")
    if not re.match(r"^(SELECT|WITH)\b", cleaned, re.IGNORECASE):
        raise ValueError("Only read-only SELECT queries are permitted.")
    if FORBIDDEN_SQL_PATTERN.search(cleaned):
        raise ValueError("Query contains a forbidden operation.")
    if re.search(r"\bINTO\s+(OUTFILE|DUMPFILE)\b", cleaned, re.IGNORECASE):
        raise ValueError("Writing query results to files is not permitted.")
    if re.search(r"\bFOR\s+UPDATE\b|\bLOCK\s+IN\s+SHARE\s+MODE\b", cleaned, re.IGNORECASE):
        raise ValueError("Locking clauses are not permitted.")
    return cleaned


def generate_sql_from_question(question, schema_info):
    examples = "\n".join(
        [f"Question: {ex['Question']}\nSQLQuery: {ex['SQLQuery']}" for ex in few_shots]
    )
    prompt = f"""
You are a MySQL expert. Generate one syntactically correct, read-only SELECT query.

Schema:
{schema_info}

Examples:
{examples}

Question:
{question}

Return only the SQL query. Do not include comments or multiple statements.
"""
    return generate_response(prompt)


def execute_query(sql):
    try:
        safe_sql = validate_readonly_sql(sql)
        with get_engine().connect() as conn:
            return pd.read_sql(text(safe_sql), conn)
    except Exception as exc:
        # Return a concise error; avoid dumping connection details into the UI.
        return f"Unable to execute query ({type(exc).__name__}). Check the query and database configuration."
