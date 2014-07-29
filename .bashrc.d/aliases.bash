#!/bin/bash

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------

alias :e='vim'
alias :q='exit'
alias histstat='history | awk "{print $4}" | sort | uniq -c | sort -rn | head'
alias mount='mount | column -t'
alias sdig='dig +noall +answer'

# coreutils
alias cp='cp -ivr'
alias ls='ls -lah --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -iv'
alias rm='rm -iv'
