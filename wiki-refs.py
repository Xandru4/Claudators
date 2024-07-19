import re
import sys

# Define variables
title = sys.argv[1]
language = sys.argv[2]
directory = sys.argv[3]
txt = sys.argv[4]

# Define the function to clean references
def clean(text):
    ref_pattern = r'<ref.*?>.*?</ref>|<ref.*?/>'
    cleaned_text = re.sub(ref_pattern, '', text, flags=re.DOTALL)
    return cleaned_text

# Read file
def read_source(title, directory, language, txt):
    try:
        with open(f"{directory}/WP:{title}-{language}.{txt}", "r", encoding="utf-8") as file:
            return file.read()
    except FileNotFoundError:
        print(f"File {directory}/WP:{title}-{language}.{txt} not found.")
        return None

# Define elimination
wikitext = read_source(title, directory, language, txt)
if wikitext:
    cleaned_text = clean(wikitext)
    with open(f"{directory}/WP:{title}-{language}.{txt}", "w", encoding="utf-8") as file:
        file.write(cleaned_text)