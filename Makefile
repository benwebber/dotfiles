all: install

pwd = $(shell pwd)

install:
	ln -sf $(pwd)/.bashrc ~/.bashrc
	ln -sf $(pwd)/.bash_aliases ~/.bash_aliases
	ln -sf $(pwd)/.bash_osx ~/.bash_osx
	ln -sf $(pwd)/.profile ~/.profile
	ln -sf $(pwd)/.vimrc ~/.vimrc
	ln -sf $(pwd)/.vim ~/.vim
	ln -sf $(pwd)/.gvimrc ~/.gvimrc
