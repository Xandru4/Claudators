# Script to fetch the wikipedia source code and save it as a file
def fetch_wikitext(language, title):
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
