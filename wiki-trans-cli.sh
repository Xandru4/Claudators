#!/bin/bash

# Prompt for the language code
read -p "Enter the language code (e.g., 'en' for English, 'fr' for French): " language

# Check if the user entered something
if [ -z "$language" ]; then
    echo "No language code entered. Exiting."
    exit 1
fi

# Prompt for the Wikipedia article title
read -p "Enter the Wikipedia article title: " article_title

# Check if the user entered something
if [ -z "$article_title" ]; then
    echo "No article title entered. Exiting."
    exit 1
fi

# Prompt for the target language code for translation
read -p "Enter the target language code for translation (e.g., 'DE' for German, 'FR' for French): " target_language

# Check if the user entered something
if [ -z "$target_language" ]; then
    echo "No target language code entered. Exiting."
    exit 1
fi

# Run the Python script with the input values
python3 fetch_and_translate.py "$language" "$article_title" "$target_language"

# Check if the Python script ran successfully
if [ $? -eq 0 ]; then
    echo "Successfully fetched, translated, and saved the Wikipedia article."
else
    echo "Failed to fetch, translate, or save the Wikipedia article."
fi
