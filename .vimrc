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
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'

Plugin 'vim-airline/vim-airline-themes'

Plugin 'wakatime/vim-wakatime'

Plugin 'scrooloose/syntastic'

Plugin 'tpope/vim-endwise'

Plugin 'tpope/vim-obsession'

Plugin 'tpope/vim-fugitive'

Plugin 'xolox/vim-misc'

Plugin 'xolox/vim-easytags'

Plugin 'flowtype/vim-flow'

Plugin 'Shougo/vimproc.vim'

Plugin 'sbdchd/neoformat'

"provides linting and type-information for haskell
Plugin 'eagletmt/ghcmod-vim'

"provide neco-ghc for haskell completion
Plugin 'eagletmt/neco-ghc'

"syntax highlighting alternative(??)
Plugin 'neovimhaskell/haskell-vim'

Plugin 'godlygeek/tabular'

"Javascript syntax support
Plugin 'pangloss/vim-javascript'

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

"Syntax highlighting for styled-components
Plugin 'fleischie/vim-styled-components'

"Syntax highlighting for graphql
Plugin 'jparise/vim-graphql'

Plugin 'flazz/vim-colorschemes'


"Plugin fugitive for working with git
Plugin 'tpope/vim-fugitive'

"Plugin for autocompletion
Plugin 'Shougo/neocomplete.vim'

call vundle#end()

" ******************** General Settings **************************************

"remap the leader key from \ to ,
let mapleader = ','

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
inoremap <BS> <nop>
inoremap <Del> <nop>
nnoremap <BS> <nop>
nnoremap <Del> <nop>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Adjust window sizes
map <leader>w- <C-W>- " smaller
map <leader>w+ <C-W>+ " larger
map <leader>w[ <C-W>= " equal
map <leader>w] <C-W>_ " fill screen

"open new windows to the right and bottom
set splitbelow
set splitright

" splitting windows
map <leader>; <C-W>s
map <leader>` <C-W>v
"lookup documentation using `investigate.vim`

nnoremap <leader>K :call investigate#Investigate('n')<CR>
vnoremap <leader>K :call investigate#Investigate('v')<CR>

"always use dash
let g:investigate_use_dash=1

"Start scrolling three lines before the horizontal window border
set scrolloff=3

"Avoid seeing .swp, .swo and ~ files in the working directory
" the "//" at the end of each directory means that file names will be built from the complete path
" to the file with all path separators substituted to percent "%" sign.
" This will ensure file name uniqueness in the preserve directory.set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

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
  let save_cursor = getpos('.')
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.',save_cursor)
  call setreg('/',old_query)
endfunction

" changes to the order of formatters in javascript for neoformat
" first try with:
"   prettier-eslint
"   prettier-standard
"   prettier
"   followed by other formatters
" function! neoformat#formatters#javascript#enabled() abort
"  return [ 'prettiereslint', 'prettierstandard' , 'prettier', 'jsbeautify', 'prettydiff', 'clangformat', 'esformatter',  'eslint_d']
" endfunction

" add a formatter for standard with prettier
" function! neoformat#formatters#javascript#prettierstandard() abort
"   return return {
        " \ 'exe': 'prettier-standard',
        " \ 'args': ['--stdin'],
        " \ 'stdin': 1,
        " \ }
" endfunction

"configure enabled formatters in the order that they should be called:
" let g:neoformat_enabled_javascript = [ 'prettiereslint', 'prettierstandard', 'prettier', 'eslint_d' ]

" Format code when saving file or when
"   writing to a file
"   text was changed
"   leaving insert mode

noremap <leader>ss :call StripWhitespace()<CR>

"set up airline
set laststatus=2
let g:airline_powerline_fonts=1

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" ************************ Syntax Highlighting *******************************

"use the apprentice dark theme
syntax enable
colorscheme apprentice

"The following should be done automatically for the default colour scheme
"at least, but it is not in Vim 7.0.17.
if &bg ==# 'dark'
  highlight MatchParen ctermbg=darkblue guibg=blue
endif

" Group all auto commands into an augroup called vimrc
augroup vimrc

"Automatically apply template string highlighting for Javascript, Typescript
  autocmd FileType javascript JsPreTmpl html
  autocmd FileType typescript JsPreTmpl html
  autocmd FileType typescript syn clear foldBraces
  autocmd FileType typescript setlocal completeopt+=menu,preview
augroup end

"set up syntastic with the recommended settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatusLineFlag()}
set statusline+=%*

if has('autocmd')
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
  if exists('t:vex_buf_nr')
    call VexClose()
  else
    call VexOpen(a:dir)
  endif
endf

fun! VexOpen(dir)
  let g:netrw_browse_split=4 "open files in previous window
  let vex_width=40

  execute 'Vexplore ' . a:dir
  let t:vex_buf_nr = bufnr('%')
  wincmd H

  call VexSize(vex_width)
endf


fun! VexClose()
  let cur_win_nr = winnr()
  let target_nr = (cur_win_nr == 1 ? winnr('#'): cur_win_nr )
  1wincmd w
  close
  unlet t:vex_buf_nr

  execute (target_nr - 1) . 'wincmd w'
  call NormalizeWidths()
endf

fun! VexSize(vex_width)
  execute 'vertical resize' . a:vex_width
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
let g:netrw_liststyle=3
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
silent! exec 'lcd' expand('%:p:h')

let s:eslintrc_path = findfile('.eslintrc', escape(expand('<amatch>:h'),' ') . ';')
let s:has_eslintrc_path = s:eslintrc_path ==# ''

let s:has_eslintConfig = system("jq < package.json 'has(\"eslintConfig\")'") =~# 'true'

let s:eslint_path = system('PATH=$(npm bin):$PATH && which eslint')
exec 'lcd' s:lcd
let g:syntastic_vim_checkers = ['vint']
let b:syntastic_javascript_eslint_exec = substitute(s:eslint_path, '^\n*\s*\(.\{-}\)\n*\s*$', '\1', '')
let g:syntastic_javascript_flowtype_exe = 'flow'
let g:syntastic_javascript_checkers = ['eslint', 'flow' ]

"aggregate errors from all checkers for a file type
let g:syntastic_aggregate_errors = 1
"automatically open and close error list when an error is detected
let g:syntastic_always_populate_loc_list = 1
" see more debugging info to check why syntastic is not working
" let g:syntastic_debug = 3

" returns 1 if:
"   eslintConfig exists in package.json and eslint is a devDependency
"   .eslintrc exists and eslint is a devDependency in package.json
" returns 0 if
"   eslint is a devDependency but no eslintConfig or .eslintrc is found,
"   this is because eslint does not turn on any validation rules by default
"   eslint is not a devDependency
function! HasEslint()
  "a: indicates that the variable is argument scoped
  "l: specifies that a variable is local to a function

  " system executes a command in the shell and returns the result as a string
  " has is a jq filter that returns true if an object has a key, if not it returns false
  let l:pkgJsonConf = system("jq < package.json 'has(\"eslintConfig\")'") =~# 'true'

  " ==# and !=# do a case sensitive string comparision
  let l:fileConf = findfile('.eslintrc', escape(expand('<amatch>:h'),' ') . ';') !=# ''

  let l:hasConfig =  l:pkgJsonConf || l:fileConf
  let l:hasDep = system("jq < package.json '.devDependencies | has(\"eslint\")'")

  " double quote does not work in the if statement below
  let l:res = l:hasConfig == 1 && l:hasDep =~# 'true'
  " echom l:res
  return l:res
endfunction

" neoformat should try formatprg where available
let g:neoformat_try_formatprg = 1
augroup vimrc
  " if eslint is found
  if HasEslint()
    "get path of prettier-eslint
    let g:prettier_eslint_path =  system('PATH=$(npm bin):$PATH && which prettier-eslint')
    let g:prettier_eslint_path2 = substitute(g:prettier_eslint_path,'[@\^\n\t\r]', '', 'g')
    echom g:prettier_eslint_path
    echom g:prettier_eslint_path2

    if s:has_eslintrc_path
      "get full path to eslintrc if eslintrc file exists
      let g:eslintrc_full_path = getcwd() + s:eslintrc_path
      echom g:eslintrc_full_path
      autocmd FileType javascript execute "setlocal formatprg=".g:prettier_eslint_path2."\\ --filePath\\ ".g:eslintrc_full_path
    elseif s:has_eslintConfig
      let g:eslintConfig = system("jq -cr < package.json '.eslintConfig'")
      let g:eslintEscapedConfig = substitute(g:eslintConfig, '[\n\t\r]\?', '', 'g')
      echom g:eslintConfig
      echom g:eslintEscapedConfig
      autocmd FileType javascript execute "setlocal formatprg=".g:prettier_eslint_path2."\\ --eslintConfig\\ ".g:eslintEscapedConfig
    endif
  else
    " just use prettier-standard
    autocmd FileType javascript set formatprg=prettier-standard
  endif
  autocmd BufWritePre *.js Neoformat
  " autocmd BufWritePre,TextChanged,InsertLeave *.js Neoformat
augroup end

" Merge commands into augroup vimrc
" augroup vimrc
  "checks for .eslintrc and  before falling back to standard
autocmd BufNewFile,BufReadPre *.js let b:syntastic_checkers = HasEslint() ? ['eslint'] : ['standard']

augroup end

" Typescript syntax checking using tsuqoyami
let g:tsuqoyami_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tslint', 'tsuquyomi']


" *********************************************************************

" ********************* Flow type syntax highlighting ************************

let g:flow#autoclose=1

"Look for a local flowtype installation for vim-flow
let local_flow = finddir('node_modules', '.;') . '/.bin/flow'
if matchstr(local_flow, "^\/\\w") ==# ''
  let local_flow= getcwd() . '/' . local_flow
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

"Setup autocompletion for haskell using necoghc
let g:haskellmode_completion_ghc = 1
let g:neocomplete#enable_at_startup = 1
augroup vimrc
  autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup end

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

" ********************* Typescript ******************************************

"Display method signature in the popup window.
let g:tsuquyomi_completion_detail = 1

augroup vimrc

  "show method signature when you complete the arguments of a method
  autocmd FileType typescript setlocal completeopt+=menu,preview

augroup end

" *****************************************************************************

" ****************** EasyTags configuration **********************************

"Async ctags updates
let g:easytags_async = 1

"Store tags in ./tags
let g:easytags_file = '~/.vim/tags'

"Find tags either in the home or the project directories
set tags=./tags,tags;$HOME
"let g:easytags_dynamic_files = 2

"Set ctags by file type
let g:easytags_dynamic_files = 1

" *******************************************************************************
