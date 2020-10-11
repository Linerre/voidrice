" Key mappings
let mapleader = ','

noremap <Leader>ev :edit $MYVIMRC<CR>
noremap <Leader>sv :source $MYVIMRC<CR>
noremap <Leader>vv :vsplit<CR> "split view
noremap <Leader>vn :vsplit     "split to a new file
noremap <C-s> :w<Esc>
inoremap <C-s> :w<Esc>
inoremap jk <Esc>


vnoremap jk <Esc> 

inoremap [ []<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i


" nerdtree
map <C-n> :NERDTreeToggle<CR>

