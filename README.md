# Wikipedia offline edit

### Aims

Are you good with  Wikipedia markup and tired of being limited to be online in order to edit an article? Do you want to translate on the text editor of your choice without all the limitations on the offcial translation tool?

This tool (only the alpha works) will help you with all that with a few simple and customisable scripts that will give you way more control when editing wiki source code.

The scripts will assist you in fetching and doing simple operations to the source text, in order to give you all the power, but what you do with that text depends on you. Once fetched, you may make your modifications in your editor of choice [obsidian or the gnome text editor is what I use, but you may simply use notepad or vim for a minimalist approach]. Following the relevant Wikipedia regulations is paramount, just as with any other tool. This is not a tool to automatically make translations or modifications but a starting point to quickly get a woking draft.

### Scripts

**Clasico**: [[wiki-alpha.py]]
**Nuevo**: 
- [ ] [[wiki-gui.sh]]
	- [ ] ➜ wiki-fetch.py
	- [ ] ➜ wiki-refs.py
	- [ ] ➜ wiki-trans.py
	- [ ] ➜ wiki-add.py
		- [ ] wiki-es

### Tasks

**Mejoras:**
- [ ] Utilizar una o dos paginas en [[Terminal#14/ Zenity|zenity]]
- [ ] Que se pueda elegir hacer una sola cosa
- [ ] poner el proyecto en [[Nube|github]]
- [ ] Utilizar la api ? [1](https://api.wikimedia.org/wiki/Searching_for_Wikipedia_articles_using_Python) [web](https://www.mediawiki.org/wiki/API:Main_page) [so](https://stackoverflow.com/questions/627594/is-there-a-wikipedia-api/627606#627606)
- [ ] Poner los textos modelos de cada lenguage en archivos separados.
- [ ] Poner `WP:` antes de cada articulo traducido asi como el idioma y el `raw`
- [ ] add: `Thumb` > `Miniatura`, `File` > `Archivo` y comillas anglosajonas por comillas latinas
- [ ] Add specific error message for possible issues
- [ ] Poner otras opciones (locales?) de traduccion (como google translate) [guia](https://ostechnix.com/use-google-translate-commandline-linux/)
- [ ] Añador opción para separar (split) y reunir automaticamente articulos muy grandes para deepl
