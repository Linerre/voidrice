" ==========
" statusline
" ==========
"
set statusline=

" left side
set statusline+=%1*\ [B-%.2n]\ %*
set statusline+=%2*\ %t\ %*
set statusline+=\ %m 

" right side
set statusline+=%=
set statusline+=[%{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}]
set statusline+=\ %l
set statusline+=\-%02.3c 
set statusline+=\: 
set statusline+=%L 
set statusline+=\  
set statusline+=%3*\%3.3p%%\ %*

" colors
highlight User1 guifg=#e8e8d3 guibg=#478061
highlight User2 guifg=#21252a guibg=#c4c49f
highlight User3 guifg=#d3ebe9 guibg=#33859d




