import re
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sqlalchemy import create_engine, text

from config import model, DATABASE_URL
from sql_utils import validate_readonly_sql
from viz_utils import SAFE_BUILTINS, coerce_decimal_columns, patch_heatmap_code, validate_viz_ast


def get_data_from_mysql(query):
    try:
        safe_sql = validate_readonly_sql(query)
        engine = create_engine(DATABASE_URL, pool_pre_ping=True)
        with engine.connect() as conn:
            return pd.read_sql(text(safe_sql), conn)
    except Exception as exc:
        print(f"Error executing query ({type(exc).__name__}).")
        return None


def generate_visualization_code(question, df_columns):
    prompt = f"""
You are a Python data visualization assistant.
Given a user query and the column names of a pandas DataFrame df, generate Python code using matplotlib or seaborn.

Query: "{question}"
Columns: {df_columns}

Requirements:
- Return executable Python code only, optionally inside triple backticks.
- Assume df, pd, np, plt, and sns are already defined.
- Do not include import statements.
- Create an appropriate plot and add useful titles, labels, and legends.
- Do not generate sample data or recreate df.
- Use plt.tight_layout().
"""
    try:
        response = model.generate_content(prompt)
        raw_code = response.text.strip() if response and getattr(response, "text", None) else ""
        match = re.search(r"```(?:[a-zA-Z0-9_-]*)\s*\n(.*?)```", raw_code, re.DOTALL)
        return match.group(1).strip() if match else raw_code.strip()
    except Exception as exc:
        print(f"Error generating visualization code ({type(exc).__name__}).")
        return None


def visualize_data(code, df):
    try:
        if not code:
            raise ValueError("No visualization code was generated.")
        df_clean = coerce_decimal_columns(df)
        code = patch_heatmap_code(code)
        validate_viz_ast(code)
        plt.close("all")
        restricted_globals = {"__builtins__": SAFE_BUILTINS}
        local_namespace = {"df": df_clean, "plt": plt, "pd": pd, "sns": sns, "np": np}
        # Restricted exec is defense-in-depth, not a complete sandbox.
        exec(code, restricted_globals, local_namespace)
        plt.tight_layout()
        plt.show()
    except Exception as exc:
        print(f"Error executing visualization code ({type(exc).__name__}).")
    finally:
        plt.close("all")


def get_database_schema():
    try:
        engine = create_engine(DATABASE_URL, pool_pre_ping=True)
        with engine.connect() as conn:
            tables = pd.read_sql(text("SHOW TABLES"), conn)
            schema_info = ""
            for table in tables.iloc[:, 0]:
                quoted_table = str(table).replace("`", "``")
                schema_info += f"\nTable: {table}\n"
                columns = pd.read_sql(text(f"DESCRIBE `{quoted_table}`"), conn)
                for _, row in columns.iterrows():
                    schema_info += f" - {row['Field']} ({row['Type']})\n"
            return schema_info.strip()
    except Exception as exc:
        print(f"Error fetching schema ({type(exc).__name__}).")
        return ""


def generate_sql_from_description(data_description):
    schema = get_database_schema()
    prompt = f"""
You are a professional SQL assistant.

Use the following data description to generate one read-only MySQL SELECT query:
"{data_description}"

Here is the schema:
{schema}

Output only the SQL code. No explanations or comments.
"""
    try:
        response = model.generate_content(prompt)
        raw_sql = response.text.strip() if response and getattr(response, "text", None) else ""
        match = re.search(r"```(?:[a-zA-Z0-9_-]*)\s*\n(.*?)```", raw_sql, re.DOTALL)
        return match.group(1).strip() if match else raw_sql.strip()
    except Exception as exc:
        print(f"Error generating SQL ({type(exc).__name__}).")
        return None


def main():
    description = "Visualize how many t shirt remain every brand size."
    query = generate_sql_from_description(description)
    if not query:
        print("Failed to generate SQL query.")
        return
    df = get_data_from_mysql(query)
    if df is None:
        print("Failed to retrieve data from MySQL.")
        return
    code = generate_visualization_code(description, list(df.columns))
    if code:
        print("Generated visualization code:\n", code)
        visualize_data(code, df.copy())
    else:
        print("Failed to generate visualization code.")


if __name__ == "__main__":
    main()
