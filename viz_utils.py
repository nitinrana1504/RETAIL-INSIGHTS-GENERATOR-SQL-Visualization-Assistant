import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from gemini_utils import generate_response
import streamlit as st
import re

def generate_visualization_code(df_columns, description):
    prompt = f"""
You are a data visualization expert. A Pandas DataFrame named `df` is already defined and contains the query result.
Its columns are: {df_columns}

Description: "{description}"

Write Python code using seaborn/matplotlib to visualize the data.
Do not redefine or create `df`. Do not define functions or print anything. No plt.show().
"""
    return generate_response(prompt)

def patch_heatmap_code(code: str) -> str:
    """
    Automatically patch heatmap code that uses fmt='d' to avoid float formatting errors.
    """
    code = re.sub(r"fmt\s*=\s*['\"]d['\"]", "fmt='.0f'", code)

    return code

def render_visual(df, description):
    code = generate_visualization_code(df.columns.tolist(), description)
    code = patch_heatmap_code(code)  
    st.code(code, language="python")
    try:
        local_vars = {"df": df.copy(), "plt": plt, "sns": sns, "pd": pd}
        exec(code, {}, local_vars)
        st.pyplot(plt)
    except Exception as e:
        st.error(f"Visualization error: {e}")
