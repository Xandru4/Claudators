import requests
import sys

# Script to fetch the wikipedia source code and save it as file
def fetch_source(language, title):
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
        response.raise_for_status()
        data = response.json()
        page = next(iter(data['query']['pages'].values()))
        if 'revisions' in page:
            return page['revisions'][0]['slots']['main']['*']
        
if len(sys.argv) != 3:
    print("Usage: python script.py <language> <title>")
    sys.exit(1)
    
language = sys.argv[1]
title = sys.argv[2]
    
wikitext = fetch_source(language, title)
if wikitext:
    with open(f"{title}-raw", "w", encoding="utf-8") as file:
        file.write(wikitext)
    print(f"Saved {title}-raw.txt")
else:
    print("Failed to fetch the article.")