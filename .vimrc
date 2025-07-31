" Enhanced Vim Configuration
" Compatible with both vim and neovim

set nocompatible

" Basic Settings
set number
set relativenumber
set cursorline
set ruler
set showcmd
set showmatch
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set smartindent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set wrap
set linebreak
set scrolloff=8
set sidescrolloff=8
set mouse=a
set clipboard=unnamed
set backspace=indent,eol,start
set encoding=utf-8
set fileencoding=utf-8

" Visual
syntax enable
set background=dark
colorscheme default
set termguicolors

" File handling
set autoread
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undofile
set undodir=~/.vim/undo//

" Create directories if they don't exist
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p")
endif
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "p")
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p")
endif

" Key mappings
let mapleader = " "
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>x :x<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Clear search highlight
nnoremap <Leader>/ :nohlsearch<CR>

" Better paste
nnoremap <Leader>p "+p
nnoremap <Leader>y "+y

" Status line
set laststatus=2
set statusline=%f\ %m%r%h%w\ [%Y]\ [%{&ff}]\ %=%c,%l/%L\ %P