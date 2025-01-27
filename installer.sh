#!/bin/bash
 zenity --info --text="Welcome to the Claudators installation for Linux!"

# Set directories
zenity --question --title="Installation" --text="Where do you want to install Claudators?" --cancel-label="/opt (recommended)" --ok-label="Some other place"
if [ $? -eq 1 ]; then
  install_dir="/opt"
else
  install_dir=$(zenity --file-selection --title="Claudators" --directory)
  if [ $? -ne 0 ]; then
    echo "Installation canceled."
    exit 1
  fi
fi

zenity --info --title="Articles folder" --text="Where should the original articles files be stored?" --ok-label="Pick folder"
raw_dir=$(zenity --file-selection --title="Claudators" --directory)

zenity --info --title="Translations folder" --text="Where should drafts and finished translations be stored?" --ok-label="Pick folder"
trans_dir=$(zenity --file-selection --title="Claudators" --directory)

if [ -z "$install_dir" ] || [ -z "$raw_dir" ] || [ -z "$trans_dir" ]; then
  zenity --warning --text="Installation canceled"
  exit 1
fi 

cp claudators.desktop ~/.local/share/applications
cp -r . "$install_dir"

config_file="~/.config/claudators"
mkdir -p "$(dirname "$config_file")";
echo "install_dir='$install_dir'" > "$config_file"
echo "raw_dir='$raw_dir'" >> "$config_file"
echo "translated_dir='$trans_dir'" >> "$config_file"

# Install python modules
pip install requests datetime venvs | zenity --progress --percentage=0 --auto-close

# Make the python environnement
python3 -m venv .venv

# Get the deepl API key
#==add messages incase the key doesn't have the required format==
if [ $? -eq 0 ]; then
    xdg-open https://www.deepl.com/en/login
  Deepl-KEY=$(zenity --entry --title="Deepl API key" --text="You will need a Deepl API key to use the service. Make an account on their website")
    echo "Deepl-KEY='$Deepl-KEY'" >> "$config_file"
else
  zenity --warning --text="Deepl won't be available"
fi

# Final message
zenity --info --text="All set! You can find fetched articles in $raw_dir and translations in $translated_dir"
exit