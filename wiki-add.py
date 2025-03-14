import sys
import os
from datetime import datetime
date = datetime.now().strftime("%d/%m/%Y")

if len(sys.argv) != 3:
    print("Usage: wiki-add.py <translation> <language>")
    sys.exit(1)

translation_file = sys.argv[1]
target_language = sys.argv[2]

text_1 = f"wiki-{target_language}-a.md"
text_2 = f"wiki-{target_language}-b.md"

def add_file_content(translation_file, source_file):  # More descriptive name
    try:
        with open(source_file, 'r', encoding='utf-8') as src:
            content = src.read()
        with open(translation_file, 'a', encoding='utf-8') as dest:
            dest.write('\n' + content if os.path.getsize(translation_file) > 0 else content) # Add newline only if file is not empty
    except FileNotFoundError:
        print(f"File {source_file} does not exist. Skipping.")  # More general message

# Do it
add_file_content(translation_file, text_1)
add_file_content(translation_file, text_2)

#Could also be added the date of the begining of the translation