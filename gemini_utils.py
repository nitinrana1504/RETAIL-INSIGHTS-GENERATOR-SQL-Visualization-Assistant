from config import model

import re

def clean_sql(gemini_output):
    code = gemini_output.strip()
    match = re.search(r"```(?:[a-zA-Z]*)\n(.*?)```", code, re.DOTALL)
    if match:
        return match.group(1).strip()
    return code.strip()

def generate_response(prompt):
    response = model.generate_content(prompt)
    return clean_sql(response.text.strip())
