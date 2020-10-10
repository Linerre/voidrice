
let mapleader = ','

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ajmwagar/vim-deus'
call plug#end()


" Basics
set number relativenumber
" set numberwidth=4 default to 4
set nocompatible
set nohlsearch
set t_Co=256
set clipboard+=unnamedplus
set background=dark
colorscheme deus




" Keymaps
map <LEADER>ev :edit $MYVIMRC<CR>
map <LEADER>sv :source $MYVIMRC<CR>
map <LEADER>vv :vsplit<CR> "split view
map <LEADER>vn :vsplit     "split to a new file
map <C-s> :w<CR>
nnoremap <C-q> :q<CR>
inoremap jk <Esc>
vnoremap jk <Esc> 

inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
" Plugin settings
" vimtex
let g:tex_flavor = 'latex'

" ==========
" coc
" ==========
set hidden
set updatetime=100
set shortmess+=c
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_global_extensions = [
	\ 'coc-emmet',
	\ 'coc-json',
	\ 'coc-vimtex',
	\ 'coc-vimlsp',
	\ 'coc-powershell',
	\ 'coc-python'
\]

" ==========
" airline
" ==========
let g:airline_theme='base16_gruvbox_dark_hard'
