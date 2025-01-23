# Set directories
zenity --file-selection --title="Where do you want to install Claudators?" --install-dir
zenity --file-selection --title="Where should the original articles files be stored?" --raw-dir
zenity --file-selection --title="Where should drafts and translations be stored?" --translated-dir

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
  # ... implement alternative translation logic ...
fi