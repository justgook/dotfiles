:set encoding=UTF-8
:set number
:set autoindent
:set tabstop=4
:set shiftwidth=4
:set smarttab
:set softtabstop=4
:set mouse=a

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'ryanoasis/vim-devicons'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'ygm2/rooter.nvim'

call plug#end()
"-------------------Load files-----------------
lua require('init') 
source ~/.config/nvim/statusline.vim
source ~/.config/nvim/telescope.vim
source ~/.config/nvim/osx.vim

