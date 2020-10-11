" Key mappings
let mapleader = ','

noremap <Leader>ev :edit $MYVIMRC<Cr>
noremap <Leader>sv :source $MYVIMRC<Cr>
noremap <Leader>vv :vsplit<Cr> "split view
noremap <Leader>vn :vsplit     "split to a new file
noremap <C-s> <Esc>:w<Cr>
inoremap <C-s> <Esc>:w<Cr>
nnoremap <C-q> :q<Cr>
inoremap jk <Esc>
vnoremap jk <Esc> 

inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i

