import sys
import requests
import os

def translate_text(text, target_language):
    api_url = "https://api-free.deepl.com/v2/translate"
    api_key = os.getenv('DEEPL_API_KEY')  # Deepl API key must be set as an environment variable
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

if __name__ == "__main__":
    raw_file_path = sys.argv[1]
    target_language = sys.argv[2]
    article_title = sys.argv[3]
    
    with open(raw_file_path, 'r', encoding='utf-8') as file:
        text = file.read()

    translated_text = translate_text(text, target_language)

    if translated_text:
        output_directory = os.path.dirname(raw_file_path)
        translated_file_path = os.path.join(output_directory, f"{article_title.replace(' ', '_')}_translated_{target_language}.md")
        with open(translated_file_path, 'w', encoding='utf-8') as file:
            file.write(translated_text)
        print(f"Saved translated text to {translated_file_path}")

