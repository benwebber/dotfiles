.DEFAULT_GOAL := .bashrc
SOURCES        = $(shell find src -maxdepth 1 -type f -iname '*.bash' ! -name env.bash ! -name path.bash ! -name local.bash ! -name prompt.bash ! -name s.bash)
PLATFORM       = src/platform/$(shell uname).bash

.bashrc:
	cat src/path.bash > .bashrc
	cat src/env.bash >> .bashrc
	[ -f $(PLATFORM) ] && cat $(PLATFORM) >> .bashrc
	cat $(SOURCES) >> .bashrc
	cat src/prompt.bash >> .bashrc
	cat src/s.bash >> .bashrc
	cat src/local.bash >> .bashrc

clean:
	$(RM) .bashrc
