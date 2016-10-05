" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility

""""""""""""""""""""""""""""""""""
" Vim-Plug Plugin Manager Stuff "
""""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/autoload/

" Auto install Vim Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged/')

" Plugins Installation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-dispatch', {'for': 'python'}
Plug 'drgarcia1986/python-compilers.vim', {'for': 'python'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'ctrlpvim/ctrlp.vim'

" Color
Plug 'tomasr/molokai'

call plug#end()

filetype plugin indent on

""""""""""""""""""""""""""""""""
" Tab and indentation settings "
""""""""""""""""""""""""""""""""
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set softtabstop=4
set smarttab

set backspace=eol,start,indent

"""""""""""""""""""""""""
" Command mode settings "
"""""""""""""""""""""""""
set wildmenu
set wildmode=list:longest,list:full

"""""""""""""""""""""""
" Don't create backup "
"""""""""""""""""""""""
set nobackup
set nowritebackup
set noswapfile

"""""""""""""""""""
" Search settings "
"""""""""""""""""""
set hlsearch
set incsearch
set ignorecase

"" Map leader to ,
let mapleader=','

"""""""""""""""""""
" Visual settings "
"""""""""""""""""""
" colors
"set t_Co=256

colorscheme molokai
syntax on

" color column (if set)
highlight ColorColumn ctermbg=8

" show cursor line
set cursorline

" show linenumber
set nu

" To help in using of airline
set laststatus=2

" show traling spaces
set list
set listchars=trail:-,tab:\ \ ,

""""""""""""
" Commands "
""""""""""""
" Save with root privilege
command! Wroot :execute ':silent w !sudo tee % > /dev/null' | :edit!

" remove trailing whitespaces
command! CleanTrail :%s/\s\+$//e

" fix python import (based on isort)
command! -nargs=* -range=% FixPythonImports :<line1>,<line2>! isort <args> -

""""""""""
" Abbrev "
""""""""""
" Or I use this abbrevs or remove my shift key
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"""""""""""""""""
" Abbreviations "
"""""""""""""""""
iab gL logger = logging.getLogger(__name__)
iab ipdb import ipdb; ipdb.set_trace()

"""""""""""""""""
" Auto commands "
"""""""""""""""""
" show colorcolumn for column 80 in python files
augroup python
    au!
    autocmd FileType python set colorcolumn=80
    autocmd FileType python compiler flake8
    autocmd BufWrite *.py :Dispatch
augroup END

" auto syntax for *.md files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

""""""""""""""""""""
" Plugins Settings "
""""""""""""""""""""
" Netrw
let g:netrw_list_hide= '.*\.swp$,.*\.pyc,__pycache__,.DS_Store'
let g:netrw_localrmdir="rm -r"

" Airline
let g:airline_theme = 'term'
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '»'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '«'
let g:airline#extensions#readonly#symbol = '⊘'

" Vim-Go
" run GoImports on save
let g:go_fmt_command = "goimports"


"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>


"" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
