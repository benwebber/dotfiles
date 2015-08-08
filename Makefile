.PHONY: all clean install uninstall

SOURCES = $(shell find bash/src/ -maxdepth 1 -type f -iname '*.bash' ! -name env.bash ! -name local.bash)
PLATFORM = bash/src/platform/$(shell uname).bash
PACKAGES = bash gem git ipython ssh tools vim

VUNDLE_PATH = ~/.vim/bundle/Vundle.vim
VUNDLE_REPO = https://github.com/VundleVim/Vundle.vim.git
VUNDLE_REF	= v0.10.2

all: .bashrc

dist:
	mkdir -p dist

.bashrc: dist
	cat bash/src/env.bash > dist/.bashrc
	if [ -f $(PLATFORM) ]; then cat $(PLATFORM) >> dist/.bashrc; fi
	cat $(SOURCES) >> dist/.bashrc
	cat bash/src/local.bash >> dist/.bashrc

clean:
	rm -rf dist
	vim +PluginClean! +qall

install-vundle:
	git -C $(VUNDLE_PATH) fetch || git clone $(VUNDLE_REPO) $(VUNDLE_PATH)
	git -C $(VUNDLE_PATH) checkout $(VUNDLE_REF)

install: .bashrc install-vundle
	install -m 644 dist/.bashrc bash/.bashrc
	stow -R --ignore=src $(PACKAGES)
	vim +PluginInstall +qall

uninstall:
	stow -D $(PACKAGES)
