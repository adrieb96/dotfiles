set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()


"Add Plugins Here"
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline'
"Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
"Plugin 'hsanson/vim-android'
Plugin 'tpope/vim-surround'
Plugin 'sudar/vim-arduino-syntax'
Plugin 'xuhdev/vim-latex-live-preview'
Plugin 'lervag/vimtex'

"Add Before This Line"

call vundle#end()
filetype plugin indent on


set number

set ignorecase "case insensitive searching
set smartcase "case-sensitive when capital letter

set showmatch

syntax on

set encoding=utf8
let base16colorspace=256
set t_Co=256
colorscheme molokai

set autoindent
filetype plugin indent on
set tabstop=4
set shiftwidth=4


set laststatus=2

set exrc
set secure
"Plugin Settings
let g:NERDTreeQuitOnOpen=0
let NERDTreeShowHidden=1

let g:livepreview_previewer = 'mupdf'
let g:latex_view_general_viewer = 'mupdf'
let g:vimtex_view_method = 'mupdf'
