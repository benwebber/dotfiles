set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" GitHub
Plugin 'Townk/vim-autoclose'
Plugin 'bling/vim-airline'
Plugin 'chase/vim-ansible-yaml'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'fatih/vim-go'
Plugin 'godlygeek/tabular'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'jplaut/vim-arduino-ino'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'rodjek/vim-puppet'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'vim-scripts/wikipedia.vim'
Plugin 'vimwiki/vimwiki'

call vundle#end()

filetype plugin indent on
