# vim: filetype=sh

alias histstat='history | awk "{print $4}" | sort | uniq -c | sort -rn | head'
alias ls='ls -lah --color=auto'
alias ':q'="exit"
