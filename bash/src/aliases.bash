#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------

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

alias ,g='git'
# Sorted list of most frequent commands.
alias ,gs='git status'
alias ,gd='git diff'
alias ,gc='git commit'
alias ,gl='git log'
alias ,ga='git add'
alias ,gg='git grep'
alias ,gS='git show'
alias ,gC='git checkout'
alias ,gD='git diff --staged'
alias ,gp='git push'
alias ,gR='git reset'
alias ,gt='git stash'
alias ,gr='git rebase'
alias ,gri='git rebase --autosquash --interactive'
alias ,gb='git branch'
alias ,gm='git mv'
alias ,gx='git rm'
alias ,gP='git pull'
alias ,gL='git ls-files'
alias ,gM='git merge'

if [[ $(type -t __git_complete) == 'function' ]]; then
  __git_complete ,g _git
  __git_complete ,gs _git_status
  __git_complete ,gd _git_diff
  __git_complete ,gc _git_commit
  __git_complete ,gl _git_log
  __git_complete ,ga _git_add
  __git_complete ,gg _git_grep
  __git_complete ,gS _git_show
  __git_complete ,gC _git_checkout
  __git_complete ,gD _git_diff
  __git_complete ,gp _git_push
  __git_complete ,gR _git_reset
  __git_complete ,gt _git_stash
  __git_complete ,gr _git_rebase
  __git_complete ,gri _git_rebase
  __git_complete ,gb _git_branch
  __git_complete ,gm _git_mv
  __git_complete ,gx _git_rm
  __git_complete ,gP _git_pull
  __git_complete ,gL _git_ls_files
  __git_complete ,gM _git merge
fi

alias ,m='man' && complete -F _man ,m
alias ,mv='manv' && complete -F _man ,mv
alias ,mp='manp' && complete -F _man ,mp
alias ,mh='manh' && complete -F _man ,mh
