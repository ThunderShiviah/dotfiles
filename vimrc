
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Tell vim to create <Filename>.un~ files whenever you edit. These files
" contain undo info so you can undo previous actions even after you close and
" reopen a file.
set undofile

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"Display status line
set laststatus=2

" size of a hard tabstop
set tabstop=4

" size of an indent
set shiftwidth=4

"always use spaces instead of tab characters
set expandtab

" Set line number
set number

" Map : onto ;
nore ; :

" Map ; onto :
nore : ;

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"These lines manage my line wrapping settings and also show a colored column
"at 85 characters (so I can see when I write a too-long line of code). 
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=79


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on
  set smartindent
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Remap the escape key  
inoremap jk <ESC> 

inoremap ( ()<Esc>i


inoremap " ""<Esc>i

inoremap < <><Esc>i

inoremap ' ''<Esc>i

" Save when focus to current document is lost.
au FocusLost * :wa 

" <leader>w opens a new vertical split and switches over to it.
nnoremap <leader>w <C-w>v<C-w>l

" The below is for efficient navigation of window splits.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" The below fix search
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr> " This clears the search highlighting. 
nnoremap <tab> %
vnoremap <tab> %

" Remap the leader key to comma.
let mapleader = ","

"for vim-pathogen
execute pathogen#infect()

"run flake8 every time I write a python file
autocmd BufWritePost *.py call Flake8()
autocmd FileType python map <buffer> <leader>f :call Flake8()<CR>>

set foldmethod=indent
