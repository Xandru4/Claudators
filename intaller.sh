# Make the python environnement
source /home/alejandro/.virtualenvs/wiki/bin/activate

# Install python modules
pip install os rquests datetime

# Install associated services
dnf install translate-shell
#==ask the user to make a DEEPL account==

# Set directories
#==usar Zenity para determinar esto una primera vez==
article-dir:directory="/home/alejandro/Dropbox/Azahara/Hastatii/Apeiron"
installation-dir="/home/alejandro/Dropbox/Azahara/Triarii/Scripts/"
