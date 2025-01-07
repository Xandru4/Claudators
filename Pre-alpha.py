# Pre-alpha script
import requests
import os
import re
from datetime import datetime # For the date

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
        else:
            print(f"Error: No revisions found for {title}")
            return None
    except requests.RequestException as e:
        print(f"Error fetching wikitext for {title}: {e}")
        return None

def clean_urls(text):
    # Define refs to clean
    ref_pattern = r'<ref>(.*?)</ref>'
    # Define the URLs to keep
    url_pattern = r'https?://(?:www\.)?\S+\.\S+'
    # Use re.sub to replace URLs
    def replace_ref(match):
        ref_content = match.group(1)
        urls = re.findall(url_pattern, ref_content)
        if urls:
            comment = '\n\n'.join(urls)
            return f"\n\n{comment}\n\n"
        else:
            return ''
    return re.sub(ref_pattern, replace_ref, text)

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

def save_text_to_file(directory, title, text, language='', suffix='', model_start='', model_end=''):
    file_name = os.path.join(directory, f"{title.replace(' ', '_')}-{suffix}_{language}.md")
    with open(file_name, 'w', encoding='utf-8') as file:
        file.write(model_start + "\n" + text + "\n" + model_end)
    print(f"Saved text to {file_name}")

if __name__ == "__main__":
    # Prompt for inputs
    language = input("Enter ISO 3166-1-A2 compliant language code ( e.g: en=English, fr=French, es=Spanish): ").strip()
    if not language:
        print("No language code entered. Exiting.")
        exit(1)
    
    article_title = input("Enter the exact Wikipedia article title: ").strip()
    if not article_title:
        print("No article title entered. Exiting.")
        exit(1)

    translate_choice = input("Do you want to translate the article? (yes/no): ").strip().lower()
    model_choice = input("Do you want to add model text? (yes/no): ").strip().lower()
    
    # Fetch the wikitext
    wikitext = fetch_wikitext(language, article_title)
    
    if not wikitext:
        print("Failed to fetch wikitext. Exiting.")
        exit(1)

    # Clean URLs in the references taking it all away
    wikitext = clean_urls(wikitext)

    # Directory to save the files
    output_directory = os.path.expanduser('~/Dropbox/Azahara/Peltastas/Apeiron')
    os.makedirs(output_directory, exist_ok=True)
    
    current_date = datetime.now().strftime("%Y-%m-%d")
    save_text_to_file(output_directory, article_title, wikitext)
    # model texts
    model_start = f"""```lua
{{traducción}}

[[Archivo:img.png|miniatura|descr]]

Original:
https://{language}.wikipedia.org/wiki/{article_title.replace(' ', '_')}
Poner abajo:
{{Traducido ref|{language}|original|oldid=|trad=parcial|fecha={current_date}}}
Discusión:
{{Traducido de|{language}|original|oldid=|trad=parcial|fecha={current_date}}}
"""
    
    model_end = """== Referencias ==

{{listaref|2}}
{{Control de autoridades}}
== Enlaces externos ==
*

== Véase también ==

<!--¡Gracias por editarme!-->
```"""

    if translate_choice == 'yes':
        target_language = input("Enter the target language code for translation (e.g: de=German, cat=Catalan): ").strip()
        if not target_language:
            print("No target language code entered. Exiting.")
            exit(1)
            
        translated_text = translate_text(wikitext, target_language)

       
        if translated_text:
            save_text_to_file(output_directory, article_title, translated_text, target_language, f'translated_{target_language}', model_start if model_choice == 'yes' else '', model_end if model_choice == 'yes' else '')
        else:
            print("Translation failed. Exiting.")
            exit(1)
    elif translate_choice == 'no':
        save_text_to_file(output_directory, article_title, wikitext, language, 'original_with_model' if model_choice == 'yes' else 'original', model_start if model_choice == 'yes' else '', model_end if model_choice == 'yes' else '')
    else:
        print("Invalid choice for translation. Exiting.")
        exit(1)
