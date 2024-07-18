# Script to nuke the references from a given file

# Define refs to clean
def clean_urls(text): ref_pattern = r'<ref>(.*?)</ref>'

# Define variavbles
title = sys.argv[1]
directory = sys.argv[2]
txt = sys.argv[3]

# Do the thing
wikitext = fetch_source(title, directory, txt)
if wikitext:
    with open(f"{directory}/{title}-raw.md", "w", encoding="utf-8") as file:
        file.write(wikitext)
    print(f"The old references are no more")