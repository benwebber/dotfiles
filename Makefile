all: install

pwd = $(shell pwd)

clean:
	rm -f ~/.bashrc
	rm -f ~/.bashrc.d
	rm -f ~/.profile
	rm -f ~/.vimrc
	rm -f ~/.vim
	rm -f ~/.gvimrc
	rm -f ~/.gitignore_global

install: clean
	ln -s $(pwd)/.bashrc ~/.bashrc
	ln -s $(pwd)/.bashrc.d ~/.bashrc.d
	ln -s $(pwd)/.profile ~/.profile
	ln -s $(pwd)/.vimrc ~/.vimrc
	ln -s $(pwd)/.vim ~/.vim
	ln -s $(pwd)/.gvimrc ~/.gvimrc
	ln -s $(pwd)/.gitignore_global ~/.gitignore_global
