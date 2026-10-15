import streamlit as st
from sql_utils import get_table_info, generate_sql_from_question, execute_query, validate_readonly_sql
from viz_utils import render_visual

st.set_page_config(page_title="Gemini SQL + Visual App", layout="wide")
st.title("Darkness Inventory: SQL & Visualization Assistant")

mode = st.sidebar.selectbox("Choose Mode", ["Show Table", "Visualize Data"])
question = st.text_area("Enter your question", height=100)

if st.button("Run"):
    if not question.strip():
        st.warning("Please enter a question.")
    else:
        try:
            schema_info = get_table_info()
            sql = generate_sql_from_question(question, schema_info)
            safe_sql = validate_readonly_sql(sql)

            st.subheader("Generated SQL")
            st.code(safe_sql, language="sql")

            df = execute_query(safe_sql)
            if isinstance(df, str):
                st.error(df)
            elif df is not None and not df.empty:
                if mode == "Show Table":
                    st.dataframe(df, use_container_width=True)
                else:
                    render_visual(df, question)
            else:
                st.warning("No results returned.")
        except ValueError as exc:
            st.error(str(exc))
        except Exception as exc:
            st.error(f"Unable to process this request ({type(exc).__name__}). Check configuration and try again.")
