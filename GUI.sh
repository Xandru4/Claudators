#!/bin/bash
source .venv/bin/activate

# Customisable part
source /home/alejandro/.virtualenvs/wiki/bin/activate
directory="/home/alejandro/Dropbox/Azahara/Hastatii/Apeiron"
installation_path="/home/alejandro/Dropbox/Azahara/Triarii/Scripts/Claudators"
txt="md"

# Toggle the things the utility should accomplish
check_choices=$(zenity --list \
      --checklist \
      --title="Wikipedia offline translation tool" \
      --width=500 \
      --height=500 \
      --column "Select" \
      --column "Action" \
      --column "Host" \
      TRUE "Fetch_Article" "Wikipedia" \
      FALSE "Translate" "Deepl" \
      TRUE "Clean_URLs" "Script" \
      TRUE "Model_Text" "File")
# Check if the user canceled
if [ $? -eq 1 ]; then 
    echo "User canceled the selection."
    exit 1
fi
# Second form for the title and language
output=$(zenity --forms \
       --text "Wikipedia article" \
       --add-entry "Article title" \
       --add-entry "Original language" \
       --add-entry "Target language")
# Check if the user canceled
if [ $? -eq 1 ]; then
    echo "User canceled the input."
    exit 1
fi

# Split the input into separate variables
IFS='|' read -r title original_language target_language <<< "$output"

# Construct titles
title="${title// /_}"
source="$directory/WP:$title-raw.$txt"
translation="$directory/WP:$title-$target_language.$txt"

# Execute fetching
if [[ "$check_choices" == *"Fetch_Article"* ]]; then
    python $installation_path/wiki-fetch.py "$original_language" "$title" "$source" "$translation"
fi

# Execute reference elimination
if [[ "$check_choices" == *"Clean-URLs"* ]]; then
    python $installation_path/wiki-refs.py "$translation"
fi

# Execute translation
### Check if the user entered something
if [ -z "$target_language" ]; then
    echo "No target language code entered. Exiting."
    exit 1
fi
### Run the script
if [[ "$check_choices" == *"Translate"* ]]; then
    python $instalation_path/wiki-trans.py "$original_language" "$title" "$target_language" "$source" "$translation"
fi

# Execute model text addition script
if [[ "$check_choices" == *"Model_Text"* ]]; then
    python $installation_pat/wiki-add.py "$language" "$translation" "$directory" "$installation_path"
fi

# Check if the Python script ran successfully
if [ $? -eq 0 ]; then
    echo "Successfully fetched, translated, and saved the Wikipedia article."
else
    echo "Failed to fetch, translate, or save the Wikipedia article."
f`
