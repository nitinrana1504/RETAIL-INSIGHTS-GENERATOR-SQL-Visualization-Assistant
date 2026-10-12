import os
import google.generativeai as genai
from sqlalchemy import create_engine, text
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns

GENAI_KEY = os.getenv("GENAI_KEY", "your_gemini_api_key")
genai.configure(api_key=GENAI_KEY)
model = genai.GenerativeModel("gemini-2.0-flash")

MYSQL_USER = os.getenv("MYSQL_USER", "root")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD", "1234")
MYSQL_HOST = os.getenv("MYSQL_HOST", "localhost")
MYSQL_PORT = os.getenv("MYSQL_PORT", "3306")
MYSQL_DATABASE = os.getenv("MYSQL_DATABASE", "Darkness")
DATABASE_URL = f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DATABASE}"

def get_data_from_mysql(query):
    try:
        engine = create_engine(DATABASE_URL)
        with engine.connect() as connection:
            df = pd.read_sql(text(query), connection)
            return df
    except Exception as e:
        print(f"Error fetching data from MySQL: {e}")
        return None

def generate_visualization_code(data_description, df_columns):
    prompt = f"""
    You are a data visualization expert. I have a pandas DataFrame named `df` with columns: {df_columns}.
    The data is described as: "{data_description}".

    Based on this, write Python code to visualize it.

    Requirements:
    - Use the existing `df` DataFrame. DO NOT create or redefine it.
    - Use seaborn and matplotlib only.
    - Do NOT define any function.
    - Do NOT use `if __name__ == '__main__':`.
    - Do NOT include any fake or dummy data.
    - Do NOT wrap the code in markdown (no triple backticks).
    - Just write raw Python code that works.
    - Do not include plt.show(); I will call it manually.
    """

    try:
        response = model.generate_content(prompt)
        return response.text.strip() if response.text else None
    except Exception as e:
        print(f"Error generating visualization code: {e}")
        return None

def visualize_data(code, df):
    """
    Executes the generated Python code and displays the visualization.
    """
    try:
        # Sanitize code block if it includes markdown formatting
        import re
        code = code.strip()
        match = re.search(r"```(?:[a-zA-Z]*)\n(.*?)```", code, re.DOTALL)
        if match:
            code = match.group(1).strip()

        plt.clf() # Ensure a clean slate for the plot

        # Define a restricted environment
        restricted_globals = {
            "__builtins__": {
                "print": print,
                "len": len,
                "range": range,
                "int": int,
                "float": float,
                "str": str,
                "list": list,
                "dict": dict,
                "set": set,
                "tuple": tuple,
                "abs": abs,
                "min": min,
                "max": max,
                "sum": sum,
                "bool": bool,
                "enumerate": enumerate,
                "zip": zip,
            }
        }
        local_namespace = {
            "df": df,
            "plt": plt,
            "pd": pd,
            "sns": sns,
        }

        exec(code, restricted_globals, local_namespace)
        plt.show()

    except Exception as e:
        print(f"Error executing visualization code: {e}")

def get_database_schema():
    try:
        engine = create_engine(DATABASE_URL)
        with engine.connect() as conn:
            tables = pd.read_sql("SHOW TABLES", conn)
            schema_info = ""

            for table in tables.iloc[:, 0]:  # First column has table names
                schema_info += f"\nTable: {table}\n"
                columns = pd.read_sql(f"DESCRIBE {table}", conn)
                for _, row in columns.iterrows():
                    schema_info += f" - {row['Field']} ({row['Type']})\n"

            return schema_info.strip()

    except Exception as e:
        print(f"Error fetching schema: {e}")
        return ""

def generate_sql_from_description(data_description):
    schema = get_database_schema()

    prompt = f"""
    You are a professional SQL assistant.

    Use the following data description to generate a MySQL query:
    "{data_description}"

    Here is the schema:
    {schema}

    Output only the SQL code. No explanations.
    """

    try:
        response = model.generate_content(prompt)
        raw_sql = response.text.strip() if response.text else ""

        import re
        match = re.search(r"```(?:[a-zA-Z]*)\n(.*?)```", raw_sql, re.DOTALL)
        if match:
            return match.group(1).strip()

        return raw_sql.strip()
    except Exception as e:
        print(f"Error generating SQL: {e}")
        return None

def main():
    data_description = "Visualize how many t shirt remain every brand size."
    query = generate_sql_from_description(data_description)
    print("Query : ",query)
    df = get_data_from_mysql(query)
    if df is not None:
        df_columns = list(df.columns)
        code = generate_visualization_code(data_description, df_columns)
        if code:
            print("Generated Code:\n", code)
            visualize_data(code, df.copy())
        else:
            print("Failed to generate visualization code.")
    else:
        print("Failed to retrieve data from MySQL.")

if __name__ == "__main__":
    main()