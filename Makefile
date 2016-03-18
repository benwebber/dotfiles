.PHONY: all clean install uninstall

PACKAGES         = $(shell find * -maxdepth 0 -type d ! -name '.*' ! -name 'dist')
all: .bashrc

clean:
	$(MAKE) -C bash clean
	vim +PlugClean! +qall

install:
	$(MAKE) -C bash
	$(MAKE) -C vim
	stow -R --ignore='^(src|test|Makefile)' $(PACKAGES)
	vim +PlugInstall +qall
	mkdir -p ~/.logrotate
	mkdir -p ~/.history/{bash,less,mysql,psql,rediscli}

uninstall:
	stow -D $(PACKAGES)
