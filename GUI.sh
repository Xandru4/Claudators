#!/bin/bash
source $HOME/.claudator/venv/bin/activate

# Toggle the things the utility should accomplish
check_choices=$(zenity --list \
      --checklist \
      --title="Wikipedia offline translation tool" \
      --width=500 \
      --height=600 \
      --column "Select" \
      --column "Action" \
      --column "Host" \
      TRUE "Fetch_Article" "Wikipedia" \
      FALSE "Translate" "Deepl" \
      FALSE "Translate" "Google" \
      FALSE "Translate" "Microsoft" \
      FALSE "Translate" "Apertium" \
      TRUE "Clean_URLs" "script" \
      TRUE "Model_Text" "file")
# Check if the user canceled
if [ $? -eq 1 ]; then 
    zenity --warning --text="Operation selection canceled"
    exit 1
fi

# Second form for the title and language
output=$(zenity --forms \
       --text "Wikipedia article" \
       --add-entry "Article title"\
       --add-entry "Original language"\
       --add-entry "Target language"\
       --add-entry "File extension")
# Check if the user canceled
if [ $? -eq 1 ]; then
    zenity --warning --text="Operations canceled"
    exit 1
fi

# Split the input into separate variables
IFS='|' read -r title original_lan target_lan file_ext <<< "$output"

# Construct titles

title="${title// /_}"
original="$raw_dir/WP:$title-raw.$file_ext"
translation="$directory/WP:$title-$target_lan.$file_ext"

# Execute fetching
if [[ "$check_choices" == *"Fetch_Article"* ]]; then
    python wiki-fetch.py "$original_lan" "$title" "$original" "$translation"
fi

# Execute reference elimination
if [[ "$check_choices" == *"Clean-URLs"* ]]; then
    python wiki-refs.py "$translation"
fi

# Execute translation
if [[ "$check_choices" == *"Translate"* ]]; then
    ### Check if the user entered something
    if [ -z "$target_lan" ]; then
        echo "No target language code entered. Exiting."
        exit 1
    else python wiki-trans.py "$title" "$original_lan" "$target_lan" "$original" "$translation" "$file_ext"
fi

# Execute model text addition script
if [[ "$check_choices" == *"Model_Text"* ]]; then
    python wiki-add.py "$target_lan" "$translation"
fi

# Check if the Python script ran successfully
exit_code=$?
if [ $? -eq 0 ]; then
    echo "Successfully fetched, translated, and saved the Wikipedia article."
else
    echo "Failed to fetch, translate, or save the Wikipedia article."
fi
exit