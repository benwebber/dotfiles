set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'

" GitHub
Plugin 'PProvost/vim-ps1'
Plugin 'Townk/vim-autoclose'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/gist-vim'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/wikipedia.vim'

call vundle#end()

filetype plugin indent on
