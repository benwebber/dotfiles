# vim: filetype=sh

alias histstat='history | awk "{print $4}" | sort | uniq -c | sort -rn | head'
alias :q='exit'

# coreutils
alias rm='rm -iv'
alias cp='cp -ivr'
alias mv='mv -iv'
alias ls='ls -lah --color=auto'
alias mkdir='mkdir -p'

alias mount='mount | column -t'
