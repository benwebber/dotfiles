#!/bin/bash

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------

alias :e='vim'
alias :q='exit'
alias +x='chmod +x'
alias histstat='history | awk "{print $4}" | sort | uniq -c | sort -rn | head'
alias mount='mount | column -t'
alias c=clear

# Simple (s*) commands
alias sdig='dig +noall +answer'
alias shttpd='python -m SimpleHTTPServer'
alias ssmtpd='python -m smtpd -n -c DebuggingServer localhost:1025'

# coreutils
alias cp='cp -ivr'
alias grep='grep -rE'
alias ls='ls -lah --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -iv'
alias rm='rm -iv'
