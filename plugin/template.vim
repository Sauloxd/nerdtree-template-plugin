if exists('g:loaded_nerdtree_template')
    finish
endif

let g:loaded_nerdtree_template = 1
let s:TemplateBashUtils = {}

call NERDTreeAddMenuItem({'text': '(t)emplate', 'shortcut': 't', 'callback': 'NERDTreeCreateFromTemplate'})

function! g:NERDTreeCreateFromTemplate()
  if empty(g:TEMPLATES_BASE_PATH)
    call nerdtree#echo("Please set g:TEMPLATES_BASE_PATH correctly!")
    return
  endif

  let templateType = input("Select from available templates:\n".
                         \ "==========================================================\n".
                         \ "(c)omponent\n".
                         \ "e(x)it\n")

  if templateType ==# 'c'
    let componentName = input("\nWhat\'s the component name?\n")
    call g:TemplatesComponent(componentName)
  elseif templateType ==# 'x'
    call nerdtree#echo("Node Creation Aborted.")
    return
  else
    call nerdtree#echo("Node Creation Aborted.")
    return
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

    call s:TemplateBashUtils.recCopy(g:TEMPLATES_BASE_PATH . g:NERDTreePath.Slash() . l:template . "/", componentDirName)
    call s:TemplateBashUtils.replaceNamePlaceholderInFileName(componentDirName, a:name)
    call b:NERDTree.root.refresh()
    call NERDTreeRender()
  catch /^NERDTree/
    call nerdtree#echoWarning("Node Not Created.")
  endtry
endfunction

function! s:TemplateBashUtils.recCopy(origin, destination)
    call system("cp -R " . a:origin . "/ " . a:destination)
endfunction

function! s:TemplateBashUtils.replaceNamePlaceholderInFileName(destination, name)
    call system("for file in " .
      \ "`ls " . a:destination . " | grep a:name ` ; " .
      \ "do ".
      \ "mv " . a:destination . "/$file" .
      \ " " .
      \ a:destination . "/". "${file//a:name/" . a:name . "};".
      \ "done")
endfunction
