#------------------------------------------------------------------------------
# Utilities
#------------------------------------------------------------------------------

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
      curl "http://ipinfo.io/${ip}" && echo
    done
  fi
}

# Analyze an IP address using DolanSoft IP Analyzer.
# Arguments:
#   $1  IP address
# Returns:
#   None
ipalyzer() {
  if [[ -z $1 ]]; then
    printf "ipalyzer: enter IP address\n" >&2
    return 1
  fi
  $BROWSER "https://www.ipalyzer.com/${1}"
}

# Reap all zombie processes. Use with caution.
reap() {
  # shellcheck disable=SC2009
  kill -TERM "$(ps -exo stat,ppid | grep '[Zz]' | awk '{ print $2 }')"
}
