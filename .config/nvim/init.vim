set number                  " add line numbers
set nocompatible            " disable compatibility to old-time vi
set cc=80                  " set an 80 column border for good coding style
set clipboard=unnamedplus   " using system clipboard
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set backupdir=~/.cache/vim " Directory to store backup files.

let mapleader=";"
highlight Pmenu guibg=brown gui=bold

"Search and auto-complete
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set wildmode=longest,list   " get bash-like tab completions

" Indentation
set autoindent              " indent a new line the same amount as the line just typed
set tabstop=2               " number of columns occupied by a tab 
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set mouse=a                 " enable mouse click

syntax on                   " syntax highlighting
filetype plugin indent on   "allow auto-indenting depending on file type
filetype plugin on


call plug#begin('~/.vim/plugged')
 " Plugin Section
 Plug 'ryanoasis/vim-devicons'
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'scrooloose/nerdtree'
 Plug 'preservim/nerdcommenter'
 Plug 'mhinz/vim-startify'
 Plug 'nvim-lua/plenary.nvim'
 Plug 'nvim-telescope/telescope.nvim'
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'neovim/nvim-lspconfig'
 Plug 'jose-elias-alvarez/null-ls.nvim'
 Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
 Plug 'hrsh7th/cmp-nvim-lsp'
 Plug 'hrsh7th/cmp-buffer'
 Plug 'hrsh7th/cmp-path'
 Plug 'hrsh7th/cmp-cmdline'
 Plug 'hrsh7th/nvim-cmp'
 Plug 'quangnguyen30192/cmp-nvim-ultisnips'
 Plug 'vim-scripts/AfterColors.vim'
 Plug 'tami5/sqlite.lua'
 Plug 'AckslD/nvim-neoclip.lua'
call plug#end()

let g:python3_host_prog="/Users/vamsiampolu/.pyenv/versions/py3nvim/bin/python3.9"

lua require("lsp-config")
lua require("neo-clip")

" Nerdtree config
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Telescope config:
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

