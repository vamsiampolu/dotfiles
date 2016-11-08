"use vim settings instead of vi settings
set nocompatible
"when both relative number and number are active, it shows the relative number
"for all lines but the absolute line number for current line
set relativenumber 
set number 
set showmode "shows current mode down at the bottom
set backspace=indent,eol,start "allow backspace in insert mode
set autoread "reload files changed outside vim
set ruler
set showcmd
syntax on "turn on syntax highlighting

"setup vundle with the following plugins
"1. airline 2. wakatime 3. syntastic
"Vundle requires this
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'wakatime/vim-wakatime'

Plugin 'altercation/vim-colors-solarized'

Plugin 'scrooloose/syntastic'

call vundle#end()

"use the solarized dark theme
syntax enable
set background=dark
colorscheme solarized

"set up airline
set laststatus=2
let g:airline_powerline_fonts=1

"set up syntastic with the recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0 "skip checking on save and exit


"aggregate errors from all checkers for a file type
let g:syntastic_aggregate_errors = 1
"automatically open and close error list when an error is detected
let g:syntastic_always_populate_loc_list = 1

"attempt to add rubocop to syntastic as a ruby checker
let g:syntastic_ruby_checkers = ['mri','rubocop']


"Fix indentation for consistency
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab


"Start scrolling three lines before the horizontal window border
set scrolloff=3

"Strip trailing whitespace (:ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg("/")
  :%s/\s\+$//e
  call setpos(".",save_cursor)
  call setreg("/",old_query)
endfunction

noremap <leader>ss :call StripWhitespace()<CR>


filetype plugin on
filetype indent on

"Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:.

" Quicker window movement
 nnoremap <C-j> <C-w>j
 nnoremap <C-k> <C-w>k
 nnoremap <C-h> <C-w>h
 nnoremap <C-l> <C-w>l

 "open new windows to the right and bottom
 set splitbelow
 set splitright
 
" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

"save file as root(:W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

if has("autocmd")
  "Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  "Treat .md files as markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif
