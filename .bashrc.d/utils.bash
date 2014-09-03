#!/bin/bash

#------------------------------------------------------------------------------
# Utilities
#------------------------------------------------------------------------------

# Extract an arbitrary archive.
#
# Arguments:
#   $1  filename to extract
# Returns:
#   None
extract() {
  local filename=$1
  local archive
  if [[ -z $filename ]]; then
    echo "Usage: extract ARCHIVE"
    return 1
  else
    if [[ -f $filename ]]; then
      case $filename in
        *.tar.bz2|*.tbz2)
          archive="${filename/%.t*bz2}"
          mkdir "${archive}"
          tar -xjvf "${filename}" -C "${archive}"
          ;;
        *.tar.gz|*.tgz)
          archive="${filename/%.t*gz}"
          mkdir "${archive}"
          tar -xzvf "${filename}" -C "${archive}"
          ;;
        *.bz2)
          bunzip2 "${filename}"
          ;;
        *.gz)
          gunzip "${filename}"
          ;;
        *.tar)
          archive="${filename/%.tar}"
          mkdir "${archive}"
          tar -xvf "${filename}" -C "${archive}"
          ;;
        *.rar)
          archive="${filename/%.rar}"
          mkdir "${archive}"
          unrar e "${filename}" "${archive}"
          ;;
        *.zip)
          archive="${filename/%.zip}"
          mkdir "${archive}"
          unzip "${filename}" -d "${archive}"
          ;;
        *)
          echo "cannot extract '${filename}' using \`extract\`"
          ;;
      esac
    else
      echo "extract: cannot extract '${filename}': No such file"
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
