import re
from config import model


def clean_sql(gemini_output: str) -> str:
    if not gemini_output:
        return ""
    code = gemini_output.strip()
    match = re.search(r"```(?:[a-zA-Z0-9_-]*)\s*\n(.*?)```", code, re.DOTALL)
    if match:
        return match.group(1).strip()
    lines = [line for line in code.splitlines() if not line.strip().startswith("```")]
    return "\n".join(lines).strip()


def generate_response(prompt: str) -> str:
    try:
        response = model.generate_content(prompt)
        text = getattr(response, "text", "") or ""
        return clean_sql(text)
    except Exception as exc:
        # Keep provider details out of the UI; callers can handle an empty result.
        print(f"Gemini request failed: {type(exc).__name__}")
        return ""
