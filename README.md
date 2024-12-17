# « Claudators » : wikipedia offline edit tool

Are you good with Wikipedia markup and wish you could write at your on pace without being online?
Do you want to translate articles on your text editor of your choice without all the limitations on the offcial translation tool?
This tool, composed of a few simple and customisable scripts, will give you way more control and save you time when editing.

### Description

The scripts will assist you in fetching and doing simple operations to the source text, in order to give you all the power. What you do with that text depends on you. Once fetched and treated, you may open on one side the draft and in another the original and make your modifications with your text editor of choice [^1]. 

### Legality

Following the relevant Wikipedia regulations is paramount, just as it is with the official tool. This is **not** a tool to automatically make translations or modifications, but a starting point to quickly get a woking draft. Automatic translations are prohibited on most wikipedias and the tool's output isn't perfect by any means. The editor should know the language of the articles and use the draft as a mere starting point. After the article has been translated and checked, all the sources in the original have to be added through the wikipedia interface. Translating wikicode is not part of the scope of this project.

### Scripts

The tool has only tested on linux, but should work with WSL.

In the main shell script, different informations can be manually customised for every usecase.

The tool empowers to edit online but internet is obviously needed to fetch and to translate, wich is done wither through the [Translate Shell](https://www.soimort.org/translate-shell/) project, wich permits translation with several translation service or directly through the Deepl API, wich offers the best result but is limited to a freemium offer.

**Smooth but in develloppement**: 
- `wiki-gui.sh`
	- `wiki-fetch.py`
	- `wiki-refs.py`
	- `wiki-trans.py`
	- `wiki-add.py`
		- `wiki-es-1.txt`
 		- `wiki-es-2.txt`
		- `wiki-fr-1.txt`
 		- `wiki-language-N.txt`

**Rough but working**: `wiki-alpha.py`
### Tasks

- [X] Push the project on github
- [x] Make a few forms with Zenity
- [x] Separate the alpha into different one-purpose modular scripts
- [ ] The references functionality should offer the option to either
	- [x] Extract all the references (by default?)
	- [ ] Extract the URLSs (to add them via visual editor)
- [ ] Put the _model_ texts into separate files for each language
	- [x] Español
	- [ ] Français
- [x] Add `wp` before every translation and then either `raw` or a lang code on the local files
- [ ] Make python script to substitute templates (like: `Thumb` > `Miniatura`, `File` > `Archivo`) and quotation marks
- [ ] Add other translation options  such as google translate ([CLI google translate](https://ostechnix.com/use-google-translate-commandline-linux/))
	- [ ] Add a local translation tool	
- [ ] Make the normal use workflow by default with a button for the more complete interface (with all the options)
- [ ] Explore the wikipedia API to do other things (like automatically post to the sandbox or get internal link suggestions) [^2]
- [ ] Create specific error messages for specific issues (like no internet connection)
- [ ] Deploy options to split y remerge automatically articles wich are too big for Deepl
	- [x] Alternatively, the tool could work for local files so long articles can be handled manually?
- [x] Making an desktop icon for the app (bash script and for the python environement too I guess...)
	- [ ] Making a bash installer for the whole tool
	- [ ] Choose a good name and logo
- [ ] Make the whole app into an obsidian plugin? [YT](https://www.youtube.com/watch?v=kQCc7HYOfpY)

[^1]:Obsidian or the gnome text editor is what I use, but you may simply use notepad or vim for a minimalist approach.
[^2]:[Searching_for_Wikipedia_articles_using_Python](https://api.wikimedia.org/wiki/Searching_for_Wikipedia_articles_using_Python), [mediawiki.org/wiki/API](https://www.mediawiki.org/wiki/API:Main_page), [stackoverflow](https://stackoverflow.com/questions/627594/is-there-a-wikipedia-api/627606#627606).
