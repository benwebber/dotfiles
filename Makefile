.PHONY: all clean install uninstall

SOURCES          = $(shell find bash/src/ -maxdepth 1 -type f -iname '*.bash' ! -name env.bash ! -name path.bash ! -name local.bash ! -name s.bash)
PLATFORM         = bash/src/platform/$(shell uname).bash
PACKAGES         = $(shell find * -maxdepth 0 -type d ! -name '.*' ! -name 'dist')
VIM_PLUG_VERSION = 0.8.0
VIM_PLUG_URL     = https://raw.githubusercontent.com/junegunn/vim-plug/$(VIM_PLUG_VERSION)/plug.vim
VIM_AUTOLOAD_DIR = ~/.vim/autoload
VIM_PLUG         = $(VIM_AUTOLOAD_DIR)/plug-$(VIM_PLUG_VERSION).vim

all: .bashrc

dist:
	mkdir -p dist

.bashrc: dist
	cat bash/src/path.bash > dist/.bashrc
	cat bash/src/env.bash >> dist/.bashrc
	if [ -f $(PLATFORM) ]; then cat $(PLATFORM) >> dist/.bashrc; fi
	cat $(SOURCES) >> dist/.bashrc
	cat bash/src/s.bash >> dist/.bashrc
	cat bash/src/local.bash >> dist/.bashrc

clean:
	rm -rf dist
	vim +PlugClean! +qall

$(VIM_PLUG):
	curl -fo $(VIM_AUTOLOAD_DIR)/plug-$(VIM_PLUG_VERSION).vim --create-dirs $(VIM_PLUG_URL)

install-vim-plug: $(VIM_PLUG)
	ln -sf $(VIM_AUTOLOAD_DIR)/plug-$(VIM_PLUG_VERSION).vim $(VIM_AUTOLOAD_DIR)/plug.vim

install: .bashrc install-vim-plug
	install -m 644 dist/.bashrc bash/.bashrc
	stow -R --ignore=src $(PACKAGES)
	vim +PlugInstall +qall
	mkdir -p ~/.logrotate
	mkdir -p ~/.history/{bash,less,mysql,psql,rediscli,k}

uninstall:
	stow -D $(PACKAGES)
