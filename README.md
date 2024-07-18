# Wikipedia offline edit

### Aims

Are you good with  Wikipedia markup and tired of being limited to be online in order to edit an article? Do you want to translate on the text editor of your choice without all the limitations on the offcial translation tool?

This tool (only the alpha works) will help you with all that with a few simple and customisable scripts that will give you way more control and save time when editing or translating a wikipedia article.

The scripts will assist you in fetching and doing simple operations to the source text, in order to give you all the power. What you do with that text depends on you. Once fetched and treated, you may open on one side the draft and in another the original and make your modifications with your text editor of choice [^1]. Following the relevant Wikipedia regulations is paramount, just as with the official tool.

This is not a tool to automatically make translations or modifications but a starting point to quickly get a woking draft. Automatic translations are prohibited on most wikipedias and the draft tghe tool outputs isn't perfect by any means, wich means a speaker of the translated language should translate everything using the draft as a mere starting point. After the article has been translated and checked, all the sources in the original will have to be added through the wikipedia interface according to the pertinent rules. Source translation is not in the scope of this project.

The tool has only tested on linux, but should work with WSL.

### Scripts

**Rough but working**: `wiki-alpha.py`
**Smooth but in develloppement**: 

`wiki-gui.sh`
⬇
- `wiki-fetch.py`
- `wiki-refs.py`
- `wiki-trans.py`
- `wiki-add.py`
⬇
- `wiki-language1.txt`
- `wiki-language2.txt`
 	- `wiki-languageN.txt`

### Tasks

- [X] Push the project on github
- [x] Make a few forms with Zenity
- [x] Separate the alpha into different one-purpose modular scripts
- [ ] The references functionality should offer the option to either extract the URLSs or to completely erase all the references (wich default?).
- [ ] Put the _model_ texts into separate files for each language
	- [ ] Español
	- [ ] Français
- [ ] Poner `WP:` antes de cada articulo traducido asi como el idioma y el `raw`
- [ ] add: `Thumb` > `Miniatura`, `File` > `Archivo` y sustituir comillas anglosajonas por comillas latinas
- [ ] make other translation options (local?) such as google translate ([CLI google translate](https://ostechnix.com/use-google-translate-commandline-linux/))
- [ ] Making an desktop icon for the bash script (and for the python environement too I guess...)
- [ ] Maybe I should make the normal workflow the default and also a button for a more advanced interface with all the options
- [ ]  Explore the wikipedia API to do other things (like automatically post to the sandbox or get internal link suggestions) [^2]
- [ ] Create specific error messages for specific issues (like no internet connection)
- [ ] Deploy options to split y remerge automatically articles wich are too big for Deepl
- [ ] Alternatively, the tool could work for local files so long articles can be handled manually?
- [ ] Making a bash installer for the whole tool

[^1]:Obsidian or the gnome text editor is what I use, but you may simply use notepad or vim for a minimalist approach.
[^2]:[Searching_for_Wikipedia_articles_using_Python](https://api.wikimedia.org/wiki/Searching_for_Wikipedia_articles_using_Python), [mediawiki.org/wiki/API](https://www.mediawiki.org/wiki/API:Main_page), [stackoverflow](https://stackoverflow.com/questions/627594/is-there-a-wikipedia-api/627606#627606).
