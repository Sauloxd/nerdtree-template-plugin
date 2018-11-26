# nerdtree-template-plugin
Shortcut for creating files from template

# Installation
Please, if you don't, use a plugin manager for vim.
Example using Plug:

## Plug
``` vimscript
call plug#begin()
Plug 'Sauloxd/nerdtree-template-plugin'
call plug#end()
```

# Usage
Before using, you must set a path to your templates.
this v0.0.0.0.0.0.0.0.1 only supports one template type. So
1) Set the path to your templates as:
``` vimscript
let g:TEMPLATES_BASE_PATH = '~/.dotfiles/templates'
```

2) Create your templates inside
``` bash
mkdir ~/.dotfiles/templates/components
touch ~/.dotfiles/templates/a:name.component.js
touch ~/.dotfiles/templates/a:name.scss
touch ~/.dotfiles/templates/index.js
```

It will replace a:name with the name given during usage

3) Select a DIRECTORY in NERDTree and just
<p align="center">
<img src="https://media.giphy.com/media/1kh0zgj3Jk6lucA7Jt/giphy.gif"/>
</p>
