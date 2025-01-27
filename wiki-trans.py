import sys
import requests
source ~/.config/claudators #For thre API key

# Define arguments

title = sys.argv[1]
original_lan = sys.argv[2]
target_lan = sys.argv[3]
original = sys.argv[4]
translation = sys.argv[5]


if len(sys.argv) != 6:
    print("Usage: wiki-trans.py <title> <original_lan> <target_lan> <original> <translation>")
    sys.exit(1)

# Define translation function

def translate_text(original, target_lan):
    api_url = "https://api-free.deepl.com/v2/translate"
    if not :
    params = {
        "auth_key": Deepl_KEY,
        "text": original,
        "target_lang": target_lan
    }
    try:
        response = requests.post(api_url, data=params)
        response.raise_for_status()
        result = response.json()
        return result['translations'][0]['text']
    except requests.RequestException as e:
        print(f"Error translating text: {e}")
        return None

# Translate

translated_text = translate_text(original, target_lan)
       
if translated_text:
    try:
        with open(translation, "w", encoding="utf-8") as f:
            f.write(translated_text)
        print(f"Successfully translated to {target_lan} and saved to {translation}")
    except OSError as e:
        print(f"Error saving translation to file: {e}")
        sys.exit(1)
else:
    print("Translation failed. Exiting.")
    sys.exit(1)