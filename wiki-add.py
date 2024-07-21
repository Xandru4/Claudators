import sys
import os
from datetime import datetime

date = datetime.now().strftime("%Y-%m-%d")

if len(sys.argv) != 4:
    print("Usage: wiki-add.py <translation> <language> <installation_path>")
    sys.exit(1)

translation = sys.argv[1]
language = sys.argv[2]
installation_path = sys.argv[3]

text_1 = os.path.join(installation_path, f"wiki-1-{language}.md")
text_2 = os.path.join(installation_path, f"wiki-2-{language}.md")

# Read first file for the beginning
def add_1(translation, text_1):
    # Read content from the model text file
    with open(text_1, 'r', encoding='utf-8') as src:
        content = src.read()
    # Append content to the destination file
    with open(translation, 'a', encoding='utf-8') as dest:
        dest.write('\n' + content)

def add_2(translation, text_2):
    # Read content from the model text file
    with open(text_2, 'r', encoding='utf-8') as src:
        content = src.read()
    # Append content to the destination file
    with open(translation, 'a', encoding='utf-8') as dest:
        dest.write(content + '\n')

# Do it

if os.path.exists(text_1):
    add_1(translation, text_1)
else:
    print(f"File {text_1} does not exist. Skipping model text at the beginig.")

if os.path.exists(text_2):
    add_2(translation, text_2)
else:
    print(f"File {text_2} does not exist. Skipping model text at the en.")