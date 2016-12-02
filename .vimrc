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

Plugin 'tpope/vim-endwise'

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
"use locally installed version of eslint with syntastic, extracted from mtscout6/syntastic-local-eslint.vim
let s:lcd = fnameescape(getcwd())
silent! exec "lcd" expand('%:p:h')
let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
exec "lcd" s:lcd
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')

"aggregate errors from all checkers for a file type
let g:syntastic_aggregate_errors = 1
"automatically open and close error list when an error is detected
let g:syntastic_always_populate_loc_list = 1

"add rubocop to syntastic as a ruby checker
let g:syntastic_ruby_checkers = ['mri','rubocop']

"check if a file exists
function! HasConfig(file, dir)
  return findfile(a:file,escape(a:dir,' ') . ';') !=# ''
endfunction

"checks for .eslintrc and .jshintrc before falling back to standard
autocmd BufNewFile,BufReadPre *.js  let b:syntastic_checkers =
    \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
    \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jshint'] :
    \     ['standard']

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

"remap the leader key from \ to ,
let mapleader = ","

"Strip trailing whitespace (,ss)
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

"save file as root(,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

if has("autocmd")
  "Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  "Treat .md files as markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
endif

"=========================

fun! VexToggle(dir)
  if exists("t:vex_buf_nr")
    call VexClose()
  else
    call VexOpen(a:dir)
  endif
endf

fun! VexOpen(dir)
  let g:netrw_browse_split=4 "open files in previous window
  let vex_width=25

  execute "Vexplore " . a:dir
  let t:vex_buf_nr = bufnr("%")
  wincmd H

  call VexSize(vex_width)
endf


fun! VexClose()
  let cur_win_nr = winnr()
  let target_nr = (cur_win_nr == 1 ? winnr("#"): cur_win_nr )
  1wincmd w
  close
  unlet t:vex_buf_nr

  execute (target_nr - 1) . "wincmd w"
  call NormalizeWidths()
endf

fun! VexSize(vex_width)
  execute "vertical resize" . a:vex_width
  set winfixwidth
  call NormalizeWidths()
endf

fun! NormalizeWidths()
  let eadir_pref=&eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let eadirection = eadir_pref
endf

"press :Tab to open netrw in the project directory
noremap <Leader><Tab> :call VexToggle(getcwd())<CR>
"press :` to open netrw in the directory of the file being edited
noremap <Leader>` :call VexToggle("")<CR>

augroup NetrwGroup
  autocmd! BufEnter * call NormalizeWidths()
augroup END

"optional netrw settings copied from Ivan Brennac
let g:netrw_liststyle=0
let g:netrw_banner=0
let g:netrw_altv=0
let g:netrw_preview=1

"=========================
