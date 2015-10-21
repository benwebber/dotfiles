#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------

alias :e='vim'
alias :q='exit'
alias :cd='cd'
alias +x='chmod +x'
alias vim='vim -p'
alias mount='mount | column -t'
alias c=clear

# Simple (s*) commands
alias sdig='dig +noall +answer'
alias shttpd='python -m SimpleHTTPServer'
alias ssmtpd='python -m smtpd -n -c DebuggingServer localhost:1025'

# coreutils
alias cp='cp -ivr'
alias ls='ls -lah --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -iv'
alias rm='rm -iv'

alias sortv4='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

alias apg='apg -m16'
