
" vimtex
let g:tex_flavor = 'latex'

" compile settings
let g:vimtex_compiler_latexmk = {
	\ 'continuous' : 1,
	\ 'executable' : 'latexmk',
	\ 'options'    : [
		\ '-xelatex',
		\ '-verbose',
		\ '-file-line-error',
		\ '-synctex=1',
		\ '-interaction=nonstopmod',
  \ 	],
  \ } 


" viewer settings
let g:vimtex_view_method = 'zathura'
let g:vimtex_view_general_options
	  \ = '-reuse-instance -forward-search @tex @line @pdf'
let g:vimtex_view_general_options_latexmk = '-reuse-instance'
