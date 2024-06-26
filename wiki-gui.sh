#!/bin/bash

# Toggle the things the utility should accomplish
check_choices=$(zenity --list \
      --checklist \
      --column "Action" \
      --column "Choice" \
      --column "Host" \
      TRUE Fetch_Article Wikipedia \
      TRUE Translate Deepl \
      TRUE Clean_URLs Script \
      TRUE Model_Text File)

zenity --forms \
       --text "Wikipedia article" \
       --add-entry "Wikipedia article title" \
       --add-entry "Article language" \

# Activate the fetch script
if [[ "$check_choices" == *"Fetch_Article"* ]]; then
    zenity --info --text="YAAA"
fi

# Prompt for the target language for translation and launch translation script
if [ "$check_choices" == "Translate" ]; then
    target_language=$(zenity --entry --title="Target Language for Translation" --text="To what language do you want to translate? (2/3 letter code):")
fi

# Run the Python script with the set values
python3 wiki-trans.py "$language" "$article_title" "$model_choice" "$translate_choice" "$target_language"

# Check if the script ran successfully
if [ $? -eq 0 ]; then
    zenity --info --text="Done"
else
    zenity --error --text="Failed to fetch or save the Wikipedia article."
fi
