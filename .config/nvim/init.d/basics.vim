" Basics
set encoding=UTF-8
set fileencoding="utf-8"
set nocompatible
set showmatch
set number relativenumber
set noexpandtab
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=2
set numberwidth=4
set textwidth=90
set autoindent
set wildmode=longest,list
set nohlsearch
set clipboard+=unnamedplus

"syntax on
filetype plugin indent on

"set t_Co=256
" set termguicolors

" let &t_8f = \"\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = \"\<Esc>[48;2;%lu;%lu;%lum"

set background=dark    " Setting dark mode
colorscheme gruvbox

highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)



"colorscheme deus
"let g:deus_termcolors=256

" terminal colors
let g:terminal_color_0  ='#000000'
let g:terminal_color_1  ='#d54e53'
let g:terminal_color_2  ='#98c379'
let g:terminal_color_3  ='#e5c07b'
let g:terminal_color_4  ='#4c6886'
let g:terminal_color_5  ='#c678dd'
let g:terminal_color_6  ='#83a598'
let g:terminal_color_7  ='#eaeaea'
let g:terminal_color_8  ='#000000'
let g:terminal_color_9  ='#d54e53'
let g:terminal_color_10 ='#98c07b'
let g:terminal_color_11 ='#e5c07b'
let g:terminal_color_12 ='#4c6886'
let g:terminal_color_13 ='#c678dd'
let g:terminal_color_14 ='#83a598'
let g:terminal_color_15 ='#eaeaea'

