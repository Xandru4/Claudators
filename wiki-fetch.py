import requests
import sys
import os

# Script to fetch the Wikipedia source code and save it as a file

language = sys.argv[1]
title = sys.argv[2]
directory = sys.argv[3]
txt = sys.argv[4]

def fetch_source(title, language, directory, txt):
    api_url = f"https://{language}.wikipedia.org/w/api.php"
    params = {
        "action": "query",
        "format": "json",
        "titles": title,
        "prop": "revisions",
        "rvprop": "content",
        "rvslots": "main"
    }
    
    try:
        response = requests.get(api_url, params=params)
        response.raise_for_status()  # HTTP Error message
        data = response.json()
        page = next(iter(data['query']['pages'].values()))
        if 'revisions' in page:
            return page['revisions'][0]['slots']['main']['*']
        else:
            print("No revisions found for the given title.")
            sys.exit(1)
    except requests.exceptions.RequestException as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

if len(sys.argv) != 5:
    print("Usage: python script.py <language> <title> <directory> <txt>")
    sys.exit(1)

wikitext = fetch_source(title, language, directory, txt)
if wikitext:
    with open(f"/home/alejandro/Dropbox/Azahara/Peltastas/Apeiron{directory}/{title}-raw.md", "w", encoding="utf-8") as file:
        file.write(wikitext)
    print(f"Saved {title}-raw.md")