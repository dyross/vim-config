" basic stuff

call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on
set background=dark
set autoindent
set shortmess+=I "don't show splash
set number " show line numbers
set ruler  " show col numbers

" put swp files in common directory
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/


if has("gui_running")
    " macvim stuff
    set guioptions=aAce
    "set guifont=Monaco:h12
    set guifont=Inconsolata-dz:h12
    " Maximize gvim window.
    set lines=999 columns=999
    set scrolloff=10 " make sure cursor isn't at edges
endif

set background=light
colorscheme solarized

" Sets how many lines of history VIM has to remember
set history=700
set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" tab stuff
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab


" set leader to comma
let mapleader = ","

" shift space in insert mode returns to regular
"inoremap <S-Space> <Esc>


" NERDTree stuff

" Close automatically if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
noremap <Leader>n :NERDTree<CR>


" Command-T stuff

" ignore a lot of file extensions
set wildignore=*.o,*.obj,.git,tmp,*.class,precompiled,*.jar,*.pyc,eclipse,META-INF,modules

" Gundo 
nnoremap <F5> :GundoToggle<CR>

" Tagbar
nmap <F8> :TagbarToggle<CR>
:set tags=./tags,~/src/tags

" Scala stuff for tagbar
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'o:objects',
        \ 'f:functions',
        \ 't:traits',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types'
    \ ]
\ }


" Scala stuff

" alias gq to format
au BufEnter *.scala setl formatprg=~/lib/scalariform/scalariform.sh
map <Leader>f mzggVGgq'z


" random stuff

" easy reload vimrc
map <LEADER>v :source $MYVIMRC<CR>

" run the current buffer
map <LEADER>r! :!%<CR>



" get to common repos quick
command! Api cd ~/src/api/ | :NERDTree
command! Playful cd ~/src/playful/ | :NERDTree
command! -nargs=1 Src cd ~/src/<args> | :NERDTree 



" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['n', 'v', 'i']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor



" vimbits stuff

" better command line navigation
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" reselect visual blocks after indent
vnoremap < <gv
vnoremap > >gv

" better split nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" fix behavior of capital Y
noremap Y y$

" wrapped lines and jk
nnoremap j gj
nnoremap k gk

" select all
map <Leader>a ggVG

" VAM
fun! EnsureVamIsOnDisk(vam_install_path)
  if !filereadable(a:vam_install_path.'/vim-addon-manager/.git/config')
     \&& 1 == confirm("Clone VAM into ".a:vam_install_path."?","&Y\n&N")
    " I'm sorry having to add this reminder. Eventually it'll pay off.
    call confirm("Remind yourself that most plugins ship with ".
                \"documentation (README*, doc/*.txt). It is your ".
                \"first source of knowledge. If you can't find ".
                \"the info you're looking for in reasonable ".
                \"time ask maintainers to improve documentation")
    call mkdir(a:vam_install_path, 'p')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '.shellescape(a:vam_install_path, 1).'/vim-addon-manager'
    " VAM runs helptags automatically when you install or update 
    " plugins
    exec 'helptags '.fnameescape(a:vam_install_path.'/vim-addon-manager/doc')
  endif
endf

fun! SetupVAM()
  " VAM install location:
  let vam_install_path = expand('$HOME') . '/.vim/vim-addons'
  call EnsureVamIsOnDisk(vam_install_path)
  exec 'set runtimepath+='.vam_install_path.'/vim-addon-manager'

  " Tell VAM which plugins to fetch & load:
  call vam#ActivateAddons([], {'auto_install' : 0})
endfun
call SetupVAM()
