#!/bin/bash

#------------------------------------------------------------------------------
# Utilities
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
