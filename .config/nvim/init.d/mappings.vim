" Key mappings
let mapleader = ','

noremap <silent> <Leader>ev :vsplit $MYVIMRC<CR>
noremap <silent> <Leader>sv :source $MYVIMRC<CR>
noremap <silent> <Leader>vv :vsplit<CR> "split view
noremap <silent> <Leader>vn :vsplit     "split to a new file

noremap <silent> <C-s> :w<Esc>
inoremap <silent> <C-s> :w<Esc>
inoremap jk <Esc>
vnoremap jk <Esc> 

inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i

" Move btw windows
nnoremap <silent> <A-h> :<C-w>h
nnoremap <silent> <A-j> :<C-w>j
nnoremap <silent> <A-k> :<C-w>k
nnoremap <silent> <A-l> :<C-w>l

" Move btw buffers
nnoremap <silent> <C-j> :bnext<CR>
nnoremap <silent> <C-k> :bprevious<CR>
nnoremap <silent> <C-x> :bd!<CR>

" netrw
nnoremap <silent> <Leader>f :Vexplore<CR>




