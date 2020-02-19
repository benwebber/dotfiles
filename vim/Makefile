prefix=$(HOME)/.local/share/vim

PACKAGE_DIR = $(prefix)/pack/plugins/start
PACKAGES := $(shell paste -s -d' ' packages.txt)

all: install

install:
	mkdir -p $(PACKAGE_DIR)
	vim-package $(PACKAGE_DIR) $(PACKAGES)

update: install

uninstall:
	$(RM) -r $(PACKAGE_DIR)
