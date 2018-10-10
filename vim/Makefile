prefix=$(HOME)/.local/share/vim

VIM_PLUG_VERSION = 0.10.0
VIM_PLUG_URL     = https://raw.githubusercontent.com/junegunn/vim-plug/$(VIM_PLUG_VERSION)/plug.vim
VIM_AUTOLOAD_DIR = $(prefix)/autoload
VIM_PLUG         = $(VIM_AUTOLOAD_DIR)/plug-$(VIM_PLUG_VERSION).vim

all: install

clean:
	vim +PlugClean! +qall

$(VIM_PLUG):
	curl -fo $(VIM_PLUG) --create-dirs $(VIM_PLUG_URL)
	ln -sf $(VIM_PLUG) $(VIM_AUTOLOAD_DIR)/plug.vim

install: $(VIM_PLUG) plug-install

plug-install:
	vim +PlugInstall! +qall

update:
	vim +PlugUpdate! +qall

uninstall:
	$(RM) $(VIM_PLUG)
	$(RM) $(VIM_AUTOLOAD_DIR)/plug.vim
