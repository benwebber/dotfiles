alias :e='vim'
alias :q='exit'
alias :cd='cd'
complete -F _cd :cd
alias +x='chmod +x'
alias vim='vim -p'
alias c=clear
alias rc='echo "${PIPESTATUS[@]}"'

# coreutils
alias cp='cp -ivr'
alias ls='ls -lahN --color=auto'
alias mkdir='mkdir -p'
alias mv='mv -iv'
alias rm='rm -iv'

alias sortv4='sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

alias newsboat='newsboat -q -r'

alias ,m='man' && complete -F _man ,m
alias ,mv='manv' && complete -F _man ,mv
