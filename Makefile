.PHONY: clean install uninstall update
.DEFAULT_GOAL := install

prefix   = $(HOME)

PACKAGES = $(shell find * -maxdepth 0 -type d ! -name 'stow')

# .stow-local-ignore files override .stow-global-ignore.
# This hack merges the two rulesets.
STOW_GLOBAL_IGNORE = ($(shell paste -s -d'|' stow/.stow-global-ignore))
STOW               = stow --target $(prefix) --ignore "$(STOW_GLOBAL_IGNORE)" --no-folding

clean:
	$(MAKE) -C vim clean

install:
	$(STOW) -R stow
	$(STOW) -R $(PACKAGES)
	$(MAKE) -C vim install

uninstall:
	$(STOW) -D $(PACKAGES)
	$(STOW) -D stow

update:
	git pull
	$(MAKE) -C vim update
	$(STOW) -R $(PACKAGES)
