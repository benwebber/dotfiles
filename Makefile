.PHONY: all clean install uninstall

SOURCES = $(shell find bash/src/ -maxdepth 1 -type f -iname '*.bash' ! -name env.bash)
PLATFORM = bash/src/platform/$(shell uname).bash
PACKAGES = bash gem git ssh tools vim

all: .bashrc

dist:
	mkdir -p dist

.bashrc: dist
	cat bash/src/env.bash > dist/.bashrc
	if [ -f $(PLATFORM) ]; then cat $(PLATFORM) >> dist/.bashrc; fi
	cat $(SOURCES) >> dist/.bashrc

clean:
	rm -rf dist
	vim +PluginClean! +qall

install: .bashrc
	install -m 644 dist/.bashrc bash/.bashrc
	stow -R --ignore=src $(PACKAGES)
	vim +PluginInstall +qall

uninstall:
	stow -D $(PACKAGES)
