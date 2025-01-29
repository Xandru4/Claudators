#!/bin/bash
 zenity --info --text="Welcome to the Claudators installation for Linux!"

# Move the app to the installation directory

install_dir="'$HOME'/.claudators"
mkdir "'$HOME'/.claudators" | zenity --progress --auto-close --percentage=1
cp claudators.desktop ~/.local/share/applications | zenity --progress --auto-close --percentage=10
cp -r . "$install_dir"  | zenity --progress --auto-close --percentage=20

# Crete a pyhon virtual environement and install modules
pip install venvs | zenity --progress --auto-close --percentage=40
python3 -m venv $install_dir/venv | zenity --progress --auto-close --percentage=50
source "$HOME/.claudators/venv/bin/activate" | zenity --progress --auto-close --percentage=65
pip install requests datetime venvs | zenity --progress --auto-close --percentage=75

# Set directories

#zenity --question --title="Installation" --text="Where do you want to install Claudators?" --ok-label="Some other place" --cancel-label="/opt (recommended)"
#if [ $? -eq 1 ]; then
#  mkdir /opt/Claudators
#  install_dir="/opt/Claudators"
#else
#  install_dir=$(zenity --file-selection --title="Claudators" --directory)
#  if [ $? -ne 0 ]; then
#    echo "Installation canceled."
#    exit 1
#  fi
#fi

# Ask the user for imput about directories and store it into a config file

zenity --info --title="Articles folder" --text="Where should the original articles files be stored?" --ok-label="Pick folder"
raw_dir=$(zenity --file-selection --title="Claudators" --directory)

zenity --info --title="Translations folder" --text="Where should drafts and finished translations be stored?" --ok-label="Pick folder"
trans_dir=$(zenity --file-selection --title="Claudators" --directory)

if [ -z "$install_dir" ] || [ -z "$raw_dir" ] || [ -z "$trans_dir" ]; then
  zenity --warning --text="Installation canceled"
  exit 1
fi 

config_file="$install_dir/.config"
echo "install_dir='$install_dir'" > "$config_file"
echo "raw_dir='$raw_dir'" >> "$config_file"
echo "translated_dir='$trans_dir'" >> "$config_file"


# Get the deepl API key
#==add messages incase the key doesn't have the required format==
if [ $? -eq 0 ]; then
    xdg-open https://www.deepl.com/en/login
  Deepl_KEY=$(zenity --entry --title="Deepl API key" --text="You will need a Deepl API key to use the service. Make an account on their website")
    echo "Deepl_KEY='$Deepl_KEY'" >> "$config_file"
else
  zenity --warning --text="Deepl won't be available"
fi

# Final message
zenity --info --text="All set! You can find fetched articles in $raw_dir and translations in $translated_dir"
exit