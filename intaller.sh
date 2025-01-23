# Set directories
install_dir=$(zenity --file-selection --title="Where do you want to install Claudators?" --directory-only)/Claudators
raw_dir=$(zenity --file-selection --title="Where should the original articles files be stored?" --directory-only)
translated_dir=$(zenity --file-selection --title="Where should drafts and translations be stored?" --directory-only)

if [ -z "$install_dir" ] || [ -z "$raw_dir" ] || [ -z "$translated_dir" ]; then
  echo "Installation canceled."
  exit 1
fi

cp -r . "$install_dir" 

touch $install_dir/.dirs.txt
echo "install_dir='$install_dir'" >> dirs.txt 
echo "raw_dir='$raw_dir'" >> dirs.txt
echo "translated_dir='$translated_dir'" >> dirs.txt

# Make the python environnement
python3 -m venv .venv

# Install python modules
pip install os rquests datetime venvs


# Get the deepl API key
html_tag="<a href="https://www.deepl.com/en/login">website</a>"
if [ $? -eq 0 ]; then
    zenity --entry --text="Enter your API key:" --Deepl-KEY
else
  zenity --warning --text="Deepl won't be available."
fi