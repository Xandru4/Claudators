#!/bin/bash
source /home/alejandro/.virtualenvs/wiki/bin/activate

directory="/home/alejandro/Dropbox/Azahara/Trirremes/Borradores/wiki"
instalation_path="/home/alejandro/Dropbox/Azahara/Trirremes/Scripts/Wikipedia-offline-edit/"
txt="md"

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
      FALSE "Translate" "Deepl" \
      TRUE "Clean_URLs" "Script" \
      FALSE "Model_Text" "File")
# Check if the user canceled
if [ $? -eq 1 ]; then 
    echo "User canceled the selection."
    exit 1
fi

# Second form for the title and language
output=$(zenity --forms \
       --text "Wikipedia article" \
       --add-entry "Wikipedia article title" \
       --add-entry "Article language")

# Check if the user canceled
if [ $? -eq 1 ]; then
    echo "User canceled the input."
    exit 1
fi

# Use read to split the input into separate variables
IFS='|' read -r title language <<< "$output"

# Activate the fetch script
python /home/alejandro/Dropbox/Azahara/Trirremes/Scripts/Wikipedia-offline-edit/wiki-fetch.py "$language" "$title" "$directory" "$txt"

# Prompt for the target language to translate
if [ "$check_choices" == "Translate" ]; then
    target_language=$(zenity --entry --title="Target Language for Translation" --text="To what language do you want to translate? (2/3 letter code):")
fi
# Run the translation script with the set values
python wiki-trans.py "$language" "$title" "$model" "$target_language" "$directory" "$txt"
# Check if the script ran successfully
if [ $? -eq 0 ]; then
    zenity --info --text="Done"
else
    zenity --error --text="Failed to do the recquired taks."
fi
# Execute reference elimination
python /home/alejandro/Dropbox/Azahara/Trirremes/Scripts/Wikipedia-offline-edit/wiki-refs.py "$title" "$language" "$directory" "$txt"


# Execute model text addition
python /home/alejandro/Dropbox/Azahara/Trirremes/Scripts/Wikipedia-offline-edit/wiki-refs.py