import ast
import re
from decimal import Decimal
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
import streamlit as st
from gemini_utils import generate_response

ALLOWED_MODULES = {
    "matplotlib": matplotlib,
    "matplotlib.pyplot": plt,
    "seaborn": sns,
    "pandas": pd,
    "numpy": np,
}


def _safe_import(name, globals=None, locals=None, fromlist=(), level=0):
    if level != 0 or name not in ALLOWED_MODULES:
        raise ImportError(f"Import of '{name}' is not permitted in visualization code.")
    if fromlist and name == "matplotlib":
        if any(item != "pyplot" for item in fromlist):
            raise ImportError("Only matplotlib.pyplot imports are permitted.")
        return matplotlib
    return ALLOWED_MODULES[name]


SAFE_BUILTINS = {
    "__import__": _safe_import,
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
    "round": round,
    "sorted": sorted,
    "enumerate": enumerate,
    "zip": zip,
    "map": map,
    "filter": filter,
    "any": any,
    "all": all,
}


def coerce_decimal_columns(df: pd.DataFrame) -> pd.DataFrame:
    df_clean = df.copy()
    for col in df_clean.columns:
        if df_clean[col].dtype == "object":
            non_null = df_clean[col].dropna()
            if not non_null.empty and isinstance(non_null.iloc[0], Decimal):
                df_clean[col] = df_clean[col].astype(float)
    return df_clean


def validate_viz_ast(code: str) -> None:
    if not isinstance(code, str) or not code.strip():
        raise ValueError("No visualization code was generated.")
    tree = ast.parse(code)
    allowed_roots = {"matplotlib", "seaborn", "pandas", "numpy", "plt", "sns", "pd", "np"}
    forbidden_names = {
        "exec", "eval", "open", "compile", "__import__", "globals", "locals",
        "vars", "getattr", "setattr", "delattr", "breakpoint", "input",
    }
    for node in ast.walk(tree):
        if isinstance(node, (ast.Import, ast.ImportFrom)):
            if isinstance(node, ast.Import):
                for alias in node.names:
                    if alias.name not in ALLOWED_MODULES:
                        raise ValueError(f"Import '{alias.name}' is not allowed.")
            else:
                module = node.module or ""
                if module not in ALLOWED_MODULES:
                    raise ValueError(f"Import from '{module}' is not allowed.")
                if node.level:
                    raise ValueError("Relative imports are not allowed.")
        elif isinstance(node, ast.Call) and isinstance(node.func, ast.Name):
            if node.func.id in forbidden_names:
                raise ValueError(f"Forbidden function call: {node.func.id}")
        elif isinstance(node, ast.Name):
            if node.id.startswith("__") or node.id in forbidden_names:
                raise ValueError(f"Forbidden name: {node.id}")
        elif isinstance(node, ast.Attribute):
            if node.attr.startswith("__"):
                raise ValueError("Dunder attribute access is not allowed.")
        elif isinstance(node, (ast.FunctionDef, ast.AsyncFunctionDef, ast.Lambda, ast.ClassDef)):
            raise ValueError("Defining functions or classes is not permitted.")


def generate_visualization_code(df_or_columns, description):
    if isinstance(df_or_columns, pd.DataFrame):
        df_columns = {col: str(dtype) for col, dtype in df_or_columns.dtypes.items()}
    else:
        df_columns = df_or_columns

    prompt = f"""
You are a data visualization expert. A Pandas DataFrame named df already contains query results.
Its columns are: {df_columns}

Description: "{description}"

Write Python code using seaborn/matplotlib to visualize the data.
Do not redefine df or create sample data. Do not import modules; pd, np, plt, and sns are already available.
Do not define functions, use file/network/system access, or print anything. Do not call plt.show().
Return only executable Python code.
"""
    return generate_response(prompt)


def patch_heatmap_code(code: str) -> str:
    """Change integer heatmap format patterns to a float-safe format."""
    if not isinstance(code, str):
        return ""
    return re.sub(r"(fmt\s*=\s*)['\"]d['\"]", r"\1'.0f'", code)


def render_visual(df, description):
    df_clean = coerce_decimal_columns(df)
    code = generate_visualization_code(df_clean, description)
    code = patch_heatmap_code(code)
    st.code(code or "# No visualization code was generated.", language="python")
    try:
        validate_viz_ast(code)
        plt.close("all")
        plt.figure(figsize=(10, 6))
        restricted_globals = {"__builtins__": SAFE_BUILTINS}
        local_vars = {"df": df_clean, "plt": plt, "sns": sns, "pd": pd, "np": np}
        # This restricted exec environment is defense-in-depth, not a complete sandbox.
        exec(code, restricted_globals, local_vars)
        plt.tight_layout()
        st.pyplot(plt.gcf())
    except Exception as exc:
        st.error(f"Visualization error ({type(exc).__name__}). Please try a different visualization request.")
    finally:
        plt.close("all")
