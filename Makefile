.PHONY: all clean install uninstall

PACKAGES         = $(shell find * -maxdepth 0 -type d ! -name 'stow')

all:
	$(MAKE) -C bash
	$(MAKE) -C vim

clean:
	$(MAKE) -C bash clean
	vim +PlugClean! +qall

install: all
	stow -R stow
	stow -R $(PACKAGES)
	vim +PlugInstall +qall
	mkdir -p ~/.logrotate
	mkdir -p ~/.history/{bash,less,mysql,psql,rediscli}

uninstall:
	stow -D $(PACKAGES)
	stow -D stow
