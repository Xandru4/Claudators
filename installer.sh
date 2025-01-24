#!/bin/bash
# Set directories
install_dir=$(zenity --file-selection --title="Where do you want to install Claudators?" --directory-only)
raw_dir=$(zenity --file-selection --title="Where should the original articles files be stored?" --directory-only)
translated_dir=$(zenity --file-selection --title="Where should drafts and translations be stored?" --directory-only)

if [ -z "$install_dir" ] || [ -z "$raw_dir" ] || [ -z "$translated_dir" ]; then
  echo "Installation canceled."
  exit 1
fi 

cp claudators.desktop ~/.local/share/applications
cp -r . "$install_dir"

config_file="~/.config/claudators"
mkdir -p "$(dirname "$config_file")";
echo "install_dir='$install_dir'" > "$config_file"
echo "raw_dir='$raw_dir'" >> "$config_file"
echo "translated_dir='$translated_dir'" >> "$config_file"

# Install python modules
pip install os rquests datetime venvs

# Make the python environnement
python3 -m venv .venv

# Get the deepl API key
#==add messages incase the key doesn't have the required format==
html_tag="<a href="https://www.deepl.com/en/login">website</a>"
if [ $? -eq 0 ]; then
    Deepl-KEY=$(zenity --entry --title="You will need to make an account to get a limited Deepl API key from their $html_tag" --text="Enter your Deepl API key:")
    echo "Deepl-KEY='$Deepl-KEY'" >> "$config_file"
else
  zenity --warning --text="Deepl won't be available."
fi
