from config import model

def clean_sql(gemini_output):
    lines = gemini_output.strip().split('\n')
    return "\n".join([line for line in lines if not line.strip().startswith("```")])

def generate_response(prompt):
    response = model.generate_content(prompt)
    return clean_sql(response.text.strip())
