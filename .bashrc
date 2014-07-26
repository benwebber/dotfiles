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

#------------------------------------------------------------------------------
# Functions
#------------------------------------------------------------------------------

# Extract an arbitrary archive.
# Arguments:
#   $1  filename to extract
# Returns:
#   None
extract() {
  if [[ -z "$1" ]]; then
    echo "Usage: extract ARCHIVE"
    return 1
  else
    if [[ -f $1 ]]; then
      case $1 in
        *.tar.bz2|*.tbz2)
          tar -xjvf $1
          ;;
        *.tar.gz|*.tgz)
          tar -xzvf $1
          ;;
        *.bz2)
          bunzip2 $1
          ;;
        *.gz)
          gunzip $1
          ;;
        *.tar)
          tar -xvf $1
          ;;
        *.rar)
          unrar x $1
          ;;
        *.zip)
          unzip $1
          ;;
        *)
          echo "cannot extract $1 using \`extract\`"
          ;;
      esac
    else
      echo "extract: cannot extract '$1': No such file"
    fi
  fi
}

# Determine the machine's public IP address.
# Arguments:
#   None
# Returns:
#   The current machine's public IP address.
myip() {
  curl http://ifconfig.me/ip
}

# Retrieve information about IP addresses from <http://ipinfo.io/>.
# If no arguments are received, use the current machine's public IP address.
# Arguments:
#   $@  list of IP addresses
# Returns:
#   JSON-formatted DNS and GeoIP information.
ipinfo() {
  if [[ -z $1 ]]; then
    curl http://ipinfo.io/ && echo
  else
    for ip in "${@}"; do
      curl http://ipinfo.io/$ip && echo
    done
  fi
}

# Analyze an IP address using DolanSoft IP Analyzer.
# Arguments:
#   $1  IP address
# Returns:
#   None
ipanalyzer() {
  local cmd=
  if [[ $(uname) == 'Darwin' ]]; then
    cmd='open'
  else
    cmd='xdg-open'
  fi
  $cmd http://ipa.dolansoft.org/analyze?ip=$1
}

# Reap all zombie processes. Use with caution.
reap() {
  kill -TERM $(ps -exo stat,ppid | grep '[Zz]' | awk '{ print $2 }')
}

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

[[ $(uname) != 'Darwin' ]] && return

APP_DIR='/Applications'

# Used for mvim script
export VIM_APP_DIR=$APP_DIR

# Use GNU tools without the g prefix
packages=(
  'coreutils'
  'gnu-sed'
  'gnu-tar'
)
for package in "${packages[@]}"; do
  path="/usr/local/opt/${package}/libexec"
  if [[ -d $path ]]; then
    export PATH="${path}/gnubin:${PATH}"
    export MANPATH="${path}/gnuman:${MANPATH}"
  fi
done

# Function to remove a Homebrew package and all its dependencies
brew_clean() {
  for formula in "$@"; do
    echo "Removing ${formula} and dependencies..."
    brew uninstall $formula
    if [ "$(brew deps ${formula})" ]; then
      # orphaned packages && formula dependencies
      brew uninstall $(join <(brew leaves) <(brew deps "${formula}"))
    fi
  done
}

alias 'brew-clean'=brew_clean
