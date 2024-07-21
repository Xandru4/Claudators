# From alpha

if len(sys.argv) != 4:
    print("Usage: wiki-add.py <translation> <language> <installation_path>")
    sys.exit(1)

original_language = sys.argv[1]
title = sys.argv[2]
target_language = sys.argv[3]
source = sys.argv[4]
translation = sys.argv[5]

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
translated_text = translate_text(wikitext, target_language)

       
if translated_text:
    save_text_to_file(output_directory, article_title, translated_text, target_language, f'translated_{target_language}', model_start if model_choice == 'yes' else '', model_end if model_choice == 'yes' else '')
else:
    print("Translation failed. Exiting.")
    exit(1)