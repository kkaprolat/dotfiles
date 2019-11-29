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
filetype off

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

if &compatible
        set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')

  " my plugins
  call dein#add('neoclide/coc.nvim', {'rev': 'release'})
  call dein#add('scrooloose/nerdtree')
  call dein#add('scrooloose/nerdcommenter')
  call dein#add('Xuyuanp/nerdtree-git-plugin')
  call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('vim-airline/vim-airline')
  call dein#add('airblade/vim-gitgutter')

  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#end()
  call dein#save_state()
endif

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

" for coc
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" NERDTree
nmap <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * lead s:std_in=1
autocmd VimEnter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" for vim-devicons
set encoding=UTF-8

" nerdcommenter
" vim currently does not allow for Ctrl + Number
" nmap <C-7> <plug>NERDCommenterToggle
" vmap <C-7> <plug>NERDCommenterToggle
