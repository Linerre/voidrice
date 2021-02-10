" general
let g:buffet_use_devicons = 1
let g:buffet_show_index = 1

" hilight buffers
function! g:BuffetSetCustomColors()
  hi! BuffetCurrentBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#427b58 guifg=#fbf1c7
  hi! BuffetActiveBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#076678 guifg=#fbf1c7
  hi! BuffetTab cterm=NONE ctermbg=5 ctermfg=8 guibg=#458588 guifg=#282828
  hi! BuffetBuffer cterm=NONE ctermbg=5 ctermfg=8 guibg=#665c54 guifg=#ebdbb2
endfunction


