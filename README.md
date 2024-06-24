# Wikipedia offline edit

### Aims

Are you good with  Wikipedia markup and tired of being limited to be online in order to edit an article? Do you want to translate on the text editor of your choice without all the limitations on the offcial translation tool?

This tool (only the alpha works) will help you with all that with a few simple and customisable scripts that will give you way more control when editing wiki source code.

The scripts will assist you in fetching and doing simple operations to the source text, in order to give you all the power, but what you do with that text depends on you. Once fetched, you may make your modifications in your editor of choice ^[obsidian or the gnome text editor is what I use, but you may simply use notepad or vim for a minimalist approach]. Following the relevant Wikipedia regulations is paramount, just as with the official tool. This is not a tool to automatically make translations or modifications but a starting point to quickly get a woking draft.

Only tested on linux.

### Scripts

**Rough but working**: `wiki-alpha.py`
**Smooth but in develloppement**: 
- [ ] `wiki-gui.sh`
	- [ ] ➜ `wiki-fetch.py`
	- [ ] ➜ `wiki-refs.py`
	- [ ] ➜ `wiki-trans.py`
	- [ ] ➜ `wiki-add.py`
		- [ ] `wiki-es.txt`
 		- [ ] `wiki-en.txt`
 		- [ ] `wiki-fr.txt`

### Tasks

- [X] Push the project on github
- [ ] Make a few forms with Zenity
- [ ] Separate the alpha into different one-purpose modular scripts
- [ ] The references functionality should offer the option to either extract the URLSs or to completely erase all the references (wich default?).
- [ ] Make the _model_ texts into separate files for each language
- [ ] Poner `WP:` antes de cada articulo traducido asi como el idioma y el `raw`
- [ ] add: `Thumb` > `Miniatura`, `File` > `Archivo` y sustituir comillas anglosajonas por comillas latinas
- [ ] make other translation options (local?) such as google translate ^[[1](https://ostechnix.com/use-google-translate-commandline-linux/)]
- [ ] Making an desktop icon for the bash script (and for the python environement too I guess...)
- [ ] Maybe I should make the normal workflow the default and also a button for a more advanced interface with all the options
- [ ]  Explore the wikipedia API to do other things (like automatically post to the sandbox or get internal link suggestions) ^[[web](https://api.wikimedia.org/wiki/Searching_for_Wikipedia_articles_using_Python)] ^[[web](https://www.mediawiki.org/wiki/API:Main_page) [so](https://stackoverflow.com/questions/627594/is-there-a-wikipedia-api/627606#627606)]
- [ ] Create specific error messages for issues
- [ ] Deploy options to split y remerge automatically articles wich are too big for Deepl
- [ ] Alternatively, the tool could work for local files so long articles can be handled manually?
- [ ] Making a bash installer for the whole tool
