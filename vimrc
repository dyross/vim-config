" basic stuff

call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on
set background=dark

" looks bad in terminal, just use default theme
if has("gui_running")
  colorscheme solarized
endif

" Sets how many lines of history VIM has to remember
set history=700

set hlsearch "Highlight search things

set incsearch "Make search act like search in modern browsers

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


" NERDTree stuff

" Close automatically if only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Command-T stuff

" ignore a lot of file extensions
set wildignore=*.o,*.obj,.git,tmp,*.class,precompiled,*.jar,*.pyc,eclipse,META-INF,modules

" random plugins
nnoremap <F5> :GundoToggle


" Scala stuff

" alias gq to format
au BufEnter *.scala setl formatprg=~/lib/scalariform/scalariform.sh
map <Leader>f mzggVGgq'z


" random stuff

" easy reload vimrc
map ,v :source $MYVIMRC

" make sure the cursor isn't at the edges
set scrolloff=10

" get to common repos quick
command! Api cd ~/src/api/ | :NERDTree
command! Playful cd ~/src/playful/ | :NERDTree

" show line numbers
set number
