all: install

pwd = $(shell pwd)

clean:
	rm -f ~/.bashrc
	rm -f ~/.bash_aliases
	rm -f ~/.bash_osx
	rm -f ~/.profile
	rm -f ~/.vimrc
	rm -f ~/.vim
	rm -f ~/.gvimrc
	rm -f ~/.gitignore_global

install: clean
	ln -s $(pwd)/.bashrc ~/.bashrc
	ln -s $(pwd)/.bash_aliases ~/.bash_aliases
	ln -s $(pwd)/.bash_osx ~/.bash_osx
	ln -s $(pwd)/.profile ~/.profile
	ln -s $(pwd)/.vimrc ~/.vimrc
	ln -s $(pwd)/.vim ~/.vim
	ln -s $(pwd)/.gvimrc ~/.gvimrc
	ln -s $(pwd)/.gitignore_global ~/.gitignore_global
