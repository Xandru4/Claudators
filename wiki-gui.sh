#!/bin/bash
source /home/alejandro/.virtualenvs/wiki/bin/activate

import requests
import os
import re
from datetime import datetime

# Toggle the things the utility should accomplish
check_choices=$(zenity --list \
      --checklist \
      --title="Wikipedia offline edit tool" \
      --width=500 \
      --height=500 \
      --column "Select" \
      --column "Action" \
      --column "Host" \
      TRUE "Fetch_Article" "Wikipedia" \
      TRUE "Translate" "Deepl" \
      TRUE "Clean_URLs" "Script" \
      TRUE "Model_Text" "File")
# Check if the user canceled
if [ $? -eq 1 ]; then 
    echo "User canceled the selection."
    exit 1
fi

# Second form for the title
zenity --forms \
       --text "Wikipedia article" \
       --add-entry "Wikipedia article title" \
       --add-entry "Article language" \

# Use IFS to split the input into separate variables
#IFS="|" read -r title language <<< "$input"

# Use awk to define the imput variables
title=$(awk -F '|' '{print $1}' <<< "$output")
language=$(awk -F '|' '{print $2}' <<< "$output")

# Activate the fetch script
./wiki-fetch.py "$title" "$language"

# Otherwise message
if [[ "$check_choices" == *"Fetch_Article"* ]]; then
    zenity --info --text="Nothing got fetched"
fi

# Prompt for the target language to translate
if [ "$check_choices" == "Translate" ]; then
    target_language=$(zenity --entry --title="Target Language for Translation" --text="To what language do you want to translate? (2/3 letter code):")
fi
# Run the translation script with the set values
./wiki-trans.py "$language" "$article_title" "$model_choice" "$translate_choice" "$target_language"
# Check if the script ran successfully
if [ $? -eq 0 ]; then
    zenity --info --text="Done"
else
    zenity --error --text="Failed to fetch or save the Wikipedia article."
fi
# Execute reference elimination

# Execute model text addition

