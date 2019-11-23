" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1

set laststatus=2
" Vundle
set nocompatible
filetype off

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

call vundle#end()

" Plugins end
filetype plugin indent on

" Copy/Paste on right register
:set clipboard=unnamedplus

" better word wrapping
:set linebreak
:set breakindent

" traverse line breaks with arrow keys
:set whichwrap=b,s,<,>,[,]

" line numbers
:set number

" color scheme
packadd! onedark.vim
syntax on
colorscheme onedark

" Tabs
set tabstop=4        " visual spaces per TAB
set softtabstop=4    " number of spaces in tab when editing
set expandtab        " tabs are spaces

set cursorline       " highlight current line

set lazyredraw       " redraw only when we need to.

set showmatch        " highlight matching [{()}]

set incsearch        " search as characters are entered
set hlsearch         " highlight matches

set foldenable       " enable folding
set foldlevelstart=5 " 5 nested fold max
" space open / closes folds
nnoremap <space> za
set foldmethod=indent
let g:powerline_pycmd="py3"

set termguicolors
