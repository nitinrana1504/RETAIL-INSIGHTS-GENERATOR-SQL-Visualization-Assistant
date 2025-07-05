import streamlit as st
from sql_utils import get_table_info, generate_sql_from_question, execute_query
from viz_utils import render_visual

st.set_page_config(page_title="Gemini SQL + Visual App", layout="wide")
st.title("Darkness Inventory: SQL & Visualization Assistant")

mode = st.sidebar.selectbox("Choose Mode", ["Show Table", "Visualize Data"])
question = st.text_area("Enter your question", height=100)

if st.button("Run") and question.strip():
    schema_info = get_table_info()
    sql = generate_sql_from_question(question, schema_info)

    st.subheader("Generated SQL")
    st.code(sql, language="sql")

    df = execute_query(sql)
    if isinstance(df, str):
        st.error(df)
    elif df is not None and not df.empty:
        if mode == "Show Table":
            st.dataframe(df)
        else:
            render_visual(df, question)
    else:
        st.warning("No results returned.")
