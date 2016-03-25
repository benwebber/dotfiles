.PHONY: all clean install uninstall update

prefix   = $(HOME)

PACKAGES = $(shell find * -maxdepth 0 -type d ! -name 'stow')
STOW     = stow --target $(prefix)

all:
	$(MAKE) -C bash
	$(MAKE) -C vim

clean:
	$(MAKE) -w -C bash clean
	vim +PlugClean! +qall

install: all
	$(STOW) -R stow
	$(STOW) -R $(PACKAGES)
	vim +PlugInstall +qall
	mkdir -p $(prefix)/.logrotate
	mkdir -p $(prefix)/.history/{bash,less,mysql,psql,rediscli}

uninstall:
	$(STOW) -D $(PACKAGES)
	$(STOW) -D stow

update:
	git pull
	$(MAKE) -C vim update
	$(STOW) -R $(PACKAGES)
