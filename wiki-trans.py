# From alpha
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
