.DEFAULT_GOAL := .bashrc

.bashrc:
	# `--prefix-builtins` avoids collisions between m4 macros and Bash function
	#  namees.
	m4 --prefix-builtins bashrc.m4 -I src/ > .bashrc

clean:
	$(RM) .bashrc
