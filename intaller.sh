# Set directories
zenity --file-selection --title="Where do you want to install Claudators?" --install-dir
zenity --file-selection --title="Where should the original articles files be stored?" --raw-dir
zenity --file-selection --title="Where should drafts and translations be stored?" --translated-dir

# Install associated services
dnf install translate-shell python3 zenity

# Make the python environnement
python3 -m venv .venv
source .venv/bin/activate

# Install python modules
pip install os rquests datetime venvs


# Get the deepl API key
zenity --question --text="To access the recommended Deepl translation service, you will have to create an account on [their website](https://www.deepl.com/en/login)" --ok-label="I am ready to provide my API key" --cancel-label="I don't wish to use Deepl"
zenity --entry --text="Enter your API key:"