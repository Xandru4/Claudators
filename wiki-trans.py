# From alpha

def translate_text(text, target_language):
    api_url = "https://api-free.deepl.com/v2/translate"
    api_key = os.getenv('DEEPL_API_KEY')  # Use an environment variable for the API key
    if not api_key:
        print("DEEPL API key not found. Set the DEEPL_API_KEY environment variable.")   
        return None

    params = {
        "auth_key": api_key,
        "text": text,
        "target_lang": target_language
    }

    try:
        response = requests.post(api_url, data=params)
        response.raise_for_status()
        result = response.json()
        return result['translations'][0]['text']
    except requests.RequestException as e:
        print(f"Error translating text: {e}")
        return None
