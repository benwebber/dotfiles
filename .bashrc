# This is generally written from a GNU perspective. Mac-specific functionality
# and/or overrides are at the bottom.

colours=$(tput colors)
col_r='\[\e[1;31m\]'
col_reset='\[\e[0m\]'

PS1="\u@\h:\w\$ "

# red prompt for root
if [[ $EUID -eq 0 ]]; then
  PS1=${col_r}${PS1}${col_reset}
fi

# ENVIRONMENT VARIABLES 
########################

export EDITOR=vim
export HISTSIZE=10000
export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export PATH=~/bin:~/.local/bin:~/.gem/ruby/2.0.0/bin:~/.gem/ruby/1.8/bin:/usr/local/bin:/usr/local/sbin:$PATH

# FUNCTIONS AND ALIASES
########################

if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

# PYTHON 
#########

# Configure virtualenv
export PROJECT_HOME=$HOME/projects
export WORKON_HOME=$HOME/.virtualenvs

virtualenvwrapper="/usr/local/bin/virtualenvwrapper.sh"

if [ -f $virtualenvwrapper ]; then
  source $virtualenvwrapper
fi

# Bash completion files. Search multiple directories.
completion_dirs=(
  '~/.bash_completion.d'
  '/etc/bash_completion.d'
  '/usr/local/etc/bash_completion.d'
)
completion_files=(
  'git-completion.bash'
  'tig-completion.bash'
)
for cdir in "${completion_dirs[@]}"; do
  for cfile in "${completion_files[@]}"; do
    if [ -f "${cdir}/${cfile}" ]; then
      source "${cdir}/${cfile}"
    fi
  done
done

# MAC-SPECIFIC STUFF
######################

if [ $(uname) == 'Darwin' -a -f ~/.bash_osx ]; then
  source ~/.bash_osx
fi
