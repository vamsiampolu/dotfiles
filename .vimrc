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

Plugin 'xolox/vim-misc'

Plugin 'xolox/vim-easytags'

Plugin 'flowtype/vim-flow'

Plugin 'Shougo/vimproc.vim'

Plugin 'godlygeek/tabular'

"provides linting and type-information for haskell
Plugin 'eagletmt/ghcmod-vim'

"syntax highlighting alternative(??)
Plugin 'neovimhaskell/haskell-vim'

"Javascript syntax support Plugin 'pangloss/vim-javascript'

"JSX support for React
Plugin 'mxw/vim-jsx'

"JSON highlighting plugin
Plugin 'leshill/vim-json'

"Plugin for highlighting template strings in javascript
Plugin 'Quramy/vim-js-pretty-template'

" typescript syntax highlighting
Plugin 'leafgarland/typescript-vim'

" Tsuqoyami IDE for Typescript
Plugin 'Quramy/tsuquyomi'

" Angular CLI Plugin
Plugin 'bdauria/angular-cli.vim'

call vundle#end()

" ******************** General Settings **************************************

"remap the leader key from \ to ,
let mapleader = ","

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

"open new windows to the right and bottom
set splitbelow
set splitright

"Start scrolling three lines before the horizontal window border
set scrolloff=3

" *********************************************************************************

" ********************** Indentation *****************************************

"Fix indentation for consistency

filetype plugin on
filetype indent on

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

"Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:.

"Strip trailing whitespace (,ss)
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg("/")
  :%s/\s\+$//e
  call setpos(".",save_cursor)
  call setreg("/",old_query)
endfunction

noremap <leader>ss :call StripWhitespace()<CR>

" *********************************************************************************

"set up airline
set laststatus=2
let g:airline_powerline_fonts=1

" ************************ Syntax Highlighting *******************************

"use the solarized dark theme
syntax enable
set background=dark
colorscheme solarized

"The following should be done automatically for the default colour scheme
"at least, but it is not in Vim 7.0.17.
if &bg == "dark"
  highlight MatchParen ctermbg=darkblue guibg=blue
endif

" Group all auto commands into an augroup called vimrc
augroup vimrc

  "Automatically apply template string highlighting for Javascript, Typescript
  autocmd FileType javascript JsPreTmpl html
  autocmd FileType typescript JsPreTmpl html
  autocmd FileType typescript syn clear foldBraces
augroup end

"set up syntastic with the recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

if has("autocmd")
 " Merge autocommands into the vimrc group
  augroup vimrc
    "Treat .md files as markdown
    autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  augroup end
endif

"save file as root(,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

"jsdoc plugin highlighting
let g:javascript_plugin_jsdoc = 1

"Highlight jsx in js files
let g:jsx_ext_required = 0

"Enable flow plugin syntax
let g:javascript_plugin_flow = 1

"Make the completion menus readable
highlight Pmenu ctermfg=0 ctermbg=3
highlight PmenuSel ctermfg=0 ctermbg=7


" *********************************************************************************

" ********************** Open Sidebar using netrw ****************************

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

" *********************************************************************************

" *************************** Syntastic checking *****************************

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
let g:syntastic_javascript_flowtype_exe = 'flow'
let g:syntastic_javascript_checkers = ['eslint', 'flow']

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

" Merge commands into augroup vimrc
augroup vimrc
  "checks for .eslintrc and .jshintrc before falling back to standard
  autocmd BufNewFile,BufReadPre *.js  let b:syntastic_checkers =
    \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
    \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jshint'] :
    \     ['standard']

augroup end

" Typescript syntax checking using tsuqoyami
let g:tsuqoyami_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi']

" *********************************************************************

" ********************* Flow type syntax highlighting ************************

let g:flow#autoclose=1

"Look for a local flowtype installation for vim-flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") == ''
  let local_flow= getcwd() . "/" . local_flow
endif

if executable(local_flow)
  let g:flow#flowpath = local_flow
endif

" *********************************************************************

" ****************************** Haskell *************************************

"Hook into `ghc-mod` completion capabilities
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

"Setup code formatting using haskell with tabularize
let g:haskell_tabular=1
vmap a= :Tabularize /=<CR>
vmap a;= :Tabularize /::<CR>
vmap a-= :Tabularize /-><CR>

" *********************************************************************

" ***************** Angular CLI ***********************************

" only enable angular-cli if angular is found in the node_modules within the
" current or parent directory

let g:angular_cli_stylesheet_format = 'css'
" Merge auto commands into the vimrc augroup
augroup vimrc
  autocmd VimEnter *
    if globpath('.,..','node_modules/@angular') != '' | call angular_cli#init() |
  endif
augroup end

" *********************************************************************

" ****************** EasyTags configuration **********************************

"Async ctags updates
let g:easytags_async = 1

"Store tags in ./tags
let g:easytags_file = '~/.vim/tags'

"Use project specific tag files
set tags=./tags;
let g:easytags_dynamic_files = 2

"Set ctags by file type
let g:easytags_dynamic_files = 1

" *******************************************************************************
