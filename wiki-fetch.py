import sys
import requests

# Set the imported terms
original_lan = sys.argv[1]
title = sys.argv[2]
source = sys.argv[3]
translation = sys.argv[4]

# Define fetching
def fetch_source(original_language, title):
    api_url = f"https://{original_lan}.wikipedia.org/w/api.php"
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
    print("Usage: python script.py <original_lan> <title>")
    sys.exit(1)

# Fetch the source content
wikitext = fetch_source(original_lan, title)
if wikitext:
    # Save the fetched content to the source file
    with open(source, "w", encoding="utf-8") as file:
        file.write(wikitext)
    # Save the same content to the translation file
    with open(translation, "w", encoding="utf-8") as file:
        file.write(wikitext)  # Correct method is file.write()
    print(f"Saved content to {source} and {translation}")
