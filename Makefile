.PHONY: all clean install

packages = bash gem git tools vim

all: install

clean:
	stow -D $(packages)

install:
	stow -R $(packages)
