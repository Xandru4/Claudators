# Make the python environnement
source /home/alejandro/.virtualenvs/wiki/bin/activate

# Install python modules
pip install os rquests datetime

# Install associated services
dnf install translate-shell

# Get the deepl API key
zenity --question --text="To access the recommended Deepl translation service, you will have to create an account on [their website](https://www.deepl.com/en/login)" --ok-label="I am ready to provide my API key" --cancel-label="I don't wish to use Deepl"
zenity --entry --text="Enter your API key:"

# Set directories
#==usar Zenity para determinar esto una primera vez==
article-dir:directory="/home/alejandro/Dropbox/Azahara/Hastatii/Apeiron"
installation-dir="/home/alejandro/Dropbox/Azahara/Triarii/Scripts/"
