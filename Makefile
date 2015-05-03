.PHONY: all clean install

packages = bash gem git tools vim

all: install

clean:
	stow -D $(packages)
	vim +PluginClean! +qall

install:
	stow -R $(packages)
	vim +PluginInstall +qall
