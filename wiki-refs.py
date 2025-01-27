import re
import sys

# Define variable
translation = sys.argv[1]

# Define the function to clean references
def clean(text):
    ref_pattern = r'<ref.*?>.*?</ref>|<ref.*?/>'
    cleaned_text = re.sub(ref_pattern, '', text, flags=re.DOTALL)
    return cleaned_text

# Read file
def read_source(translation):
    try:
        with open(f"{translation}", "r", encoding="utf-8") as file:
            return file.read()
    except FileNotFoundError:
        print(f"File {translation} not found.")
        return None

# Define elimination
wikitext = read_source(translation)
if wikitext:
    cleaned_text = clean(wikitext)
    with open(f"{translation}", "w", encoding="utf-8") as file:
        file.write(cleaned_text)
