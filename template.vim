echo 'plugin started!'

if exists('g:loaded_nerdtree_template')
    finish
endif

let g:loaded_nerdtree_template = 1
let g:TEMPLATES_BASE_PATH = '~/dev/github/nerdtree-template-plugin/nerdtree_plugin/templates'

call NERDTreeAddMenuItem({'text': '(t)emplate', 'shortcut': 't', 'callback': 'NERDTreeCreateFromTemplate'})

function! g:NERDTreeCreateFromTemplate()
  let templateType = input("Select from available templates:\n".
                         \ "==========================================================\n".
                         \ "(c)omponent\n".
                         \ "(m)odule\n")
  if templateType ==# ''
    call nerdtree#echo("Node Creation Aborted.")
    return
  endif

  if templateType ==# 'c'
    let componentName = input("\nWhat\'s the component name?:\n")
    call g:TemplatesComponent(componentName)
  elseif templateType ==# 'm'
    let componentName = input("\nWhat\'s the module name?:\n")
  endif
endfunction

function! g:TemplatesComponent(name)
  let curDirNode = g:NERDTreeFileNode.GetSelected()
	let l:template = 'component'
  let treenode = g:NERDTreeFileNode.GetSelected()

  if !treenode.path.isDirectory
    call nerdtree#echo("Please target a directory!")
    return
  end

  try
    let componentDirName = treenode.path.str() . g:NERDTreePath.Slash() . a:name
    call system("cp -R " . g:TEMPLATES_BASE_PATH . g:NERDTreePath.Slash() . l:template . "/ " . componentDirName)
    call system("for file in `ls " . componentDirName . " | grep a:name ` ; do mv " . componentDirName . "/$file " . componentDirName . "/". "${file//a:name/" . a:name . "}; done")
    call b:NERDTree.root.refresh()
    call NERDTreeRender()
    call treenode.open()
  catch /^NERDTree/
    call nerdtree#echoWarning("Node Not Created.")
  endtry
endfunction














