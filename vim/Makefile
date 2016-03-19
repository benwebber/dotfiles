VIM_PLUG_VERSION = 0.8.0
VIM_PLUG_URL     = https://raw.githubusercontent.com/junegunn/vim-plug/$(VIM_PLUG_VERSION)/plug.vim
VIM_AUTOLOAD_DIR = ~/.vim/autoload
VIM_PLUG         = $(VIM_AUTOLOAD_DIR)/plug-$(VIM_PLUG_VERSION).vim

all: install-vim-plug

$(VIM_PLUG):
	curl -fo $(VIM_AUTOLOAD_DIR)/plug-$(VIM_PLUG_VERSION).vim --create-dirs $(VIM_PLUG_URL)

install-vim-plug: $(VIM_PLUG)
	ln -sf $(VIM_AUTOLOAD_DIR)/plug-$(VIM_PLUG_VERSION).vim $(VIM_AUTOLOAD_DIR)/plug.vim

update:
	vim +PlugUpdate! +qall
