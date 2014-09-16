set nocompatible

source $HOME/.vim/mswin.vim 


"add for tags
set tags=tags;/



"Activation de la coloration et de l'intendation
syn on
set syntax=on
filetype indent on
filetype plugin on

"Afficher les n° de ligne
set nu

"Activer la souris dans vim (dans gvim elle est déjà active)
set mouse=a

"Afficher les parenthèses correspondantes
set showmatch


"Modifier la police
set guifont=Courier\ New\ 14

"Modifier la taille des tabulations
set tabstop=3
set shiftwidth=3
set softtabstop=3
set expandtab "supprime les tabulations et met des espaces


"Recherche
set incsearch
set ignorecase
set smartcase

"Complétion
set wmnu "affiche le menu
set wildmode=list:longest,list:full "affiche toutes les possibilités
set wildignore=*.o,*.r,*.so,*.sl,*.tar,*.tgz "ignorer certains types de fichiers pour la complétion des includes


"Folding
function! MyFoldFunction()
	let line = getline(v:foldstart)
	let sub = substitute(line,'/\*\|\*/\|^\s+', '', 'g')
	let lines = v:foldend - v:foldstart + 1
	return v:folddashes.sub.'...'.lines.' Lines...'.getline(v:foldend)
endfunction
"set foldmethod=syntax "Réduira automatiquement les fonctions et blocs (#region en C# par exemple)
set foldtext=MyFoldFunction() "on utilise notre fonction (optionnel)


"Orthographe
"set spelllang=en,fr
"set spell
"set spellsuggest=5

"Afficher la ligne du curseur
set cursorline


imap <C-Space> <C-x><C-o>
iab #i #include

au BufNewFile,BufRead *.tpl :set ft=html " all my .tpl files ARE html
au BufRead,BufNewFile log set filetype=newlang 
au! Syntax newlang source ~/.vim/log.vim


function! InsertCloseTag()
  " inserts the appropriate closing HTML tag
  " may require ignorecase to be set, or to type HTML tags in exactly the same case
  if &filetype == 'html' || &filetype=='php' || &filetype=='xml'
  
    " list of tags which shouldn't be closed:
    let UnaryTags = ' Area Base Br br BR DD dd Dd DT dt Dt HR hr Hr Img img IMG input INPUT Input li Li LI link LINK Link meta Meta p P Param param PARAM '

    " remember current position:
    normal mz
    normal mw

    " loop backwards looking for tags:
    let Found = 0
	let NBL = 0
    while Found == 0
		 let NBL = NBL+1
		 if NBL == 50
			 break
		endif

      " find the previous <, then go forwards one character and grab the first
      " character plus the entire word:
      execute "normal ?\<LT>\<CR>l"
      normal "zyl
      let Tag = expand('<cword>')

      " if this is a closing tag, skip back to its matching opening tag:
      if @z == '/'
        execute "normal ?\<LT>" . Tag . "\<CR>"

      " if this is a unary tag, then position the cursor for the next
      " iteration:
      elseif match(UnaryTags, ' ' . Tag . ' ') > 0
        normal h

      " otherwise this is the tag that needs closing:
      else
        let Found = 1

      endif
    endwhile " not yet found match

    " create the closing tag and insert it:
    let @z = '</' . Tag . '>'
    normal `z"zp
	normal `w
	execute "normal />\<cr>"
  else " filetype is not HTML
	normal mw
    let @z = '</'
    normal "zp`wll
  endif " check on filetype
endfunction " InsertCloseTag()
imap <lt>/ <Esc>:call InsertCloseTag()<CR>a
