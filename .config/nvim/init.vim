

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


runtime vimrcs/basics.vim
runtime vimrcs/mappings.vim
runtime vimrcs/airline.vim
runtime vimrcs/coc.vim
runtime vimrcs/vimtex.vim



