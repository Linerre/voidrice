" ==========
" coc
" ==========
set hidden
set updatetime=100
set shortmess+=c
let g:coc_global_extensions = [
	\ 'coc-emmet',
	\ 'coc-json',
	\ 'coc-vimtex',
	\ 'coc-vimlsp',
	\ 'coc-powershell',
	\ 'coc-pyright',
	\ 'coc-tabnine',
	\ 'coc-tsserver',
	\ 'coc-snippets'
\]
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                         \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use `CTRL-b` and `CTRL-n` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <C-b> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-n> <Plug>(coc-diagnostic-next)

" json file comments
autocmd FileType json syntax match Comment +\/\/.\+$+

