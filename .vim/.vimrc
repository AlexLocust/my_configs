" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2014 Feb 05
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=100		" keep 100 lines of command line history
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

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" lookup for specific .vimrc in each working directory
set exrc

" do not allow local .vimrc to do too much stuff
set secure

" use 4 columns for tab
set tabstop=4

" use 'softtabstop' same as 'shiftwidth'
set softtabstop=-1

" autoindent - 4
set shiftwidth=4

" use spaces against of tabs
set expandtab

" show line numbers
set number

set list
set listchars=tab:→∙

" enable pathogen
execute pathogen#infect()

" autostart nerdtree
let g:tagbar_autofocus = 0 " disable tagbar autofocus
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'rdnetto/YCM-Generator'
Plugin 'majutsushi/tagbar'              " Class/module browser

"""""""""""""""""
"" PYTHON MODE
"""""""""""""""""
Bundle 'klen/python-mode'

call vundle#end()            " required

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
  set background=dark
  
  let g:solarized_termcolors=256
  colorscheme solarized

"  highlight Normal ctermfg=grey ctermbg=black
endif

" YCM bindings
let mapleader=","
nnoremap <leader>jd :YcmCompleter GoTo<CR>
" Python Mode settings
let g:pymode_rope=0
let g:pymode_lint_ignore = "E501, C0110,W0102,F0401,C0301"
let g:pymode_doc=1
let g:pymode_doc_key='<f1>'
let g:pymode_lint=1
let g:pymode_lint_checker = "pyflakes,pep8"
let g:pymode_lint_write = 1
let g:pymode_virtualenv = 1
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_folding=0
iab pdb import ipdb; ipdb.set_trace()

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left> 

" Map f12 to rebuild project tags
map <f12> :!ctags -R . <cr>

" do not indent C++ namespaces
set cino=N-s

" :W - writes file with sudo
" command W w !sudo tee % > /dev/null

map <F7> :make<CR>
autocmd VimEnter * copen
autocmd VimEnter * wincmd p
autocmd VimEnter * nested :TagbarOpen

" copy/paste to system clipboard with <leader>y/p
nmap <leader>y "+y
vmap <leader>y "+y
nmap <leader>p "+p
vmap <leader>p "+p
