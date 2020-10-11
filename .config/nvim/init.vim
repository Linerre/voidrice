

" Plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'lervag/vimtex'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ajmwagar/vim-deus'
call plug#end()


runtime init.d/basics.vim
runtime init.d/mappings.vim
runtime init.d/statusline.vim
runtime init.d/coc.vim
runtime init.d/vimtex.vim

