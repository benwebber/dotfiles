#------------------------------------------------------------------------------
# Utilities
#------------------------------------------------------------------------------

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

# Look for help in multiple places.
halp() {
  if [[ -z "${@}" ]] || [[ $1 == '-h' ]] || [[ $1 == '--help' ]]; then
    printf "Usage: halp <args>...\n" >&2
    return
  fi

  case "$(type -t "${@}")" in
    alias)
      alias "${@}"
      ;;
    builtin|keyword)
      help "${@}"
      ;;
    file)
      { "${@}" help || "${@}" -h || "${@}" --help || man "${@}"; }
      ;;
    function)
      declare -f "${@}"
      ;;
    *)
      man "${@}"
      ;;
  esac
  [[ $? -ne 0 ]] && $BROWSER "https://www.google.com/search?q=${*}"
}

# Make a directory then change to it.
function mkcd() {
  mkdir -p -- "$@" && builtin cd -- "$@"
}

# Make a directory and copy files into it.
function mkcp() {
  mkdir -p -- "${@: -1}" && cp -- "$@"
}

# Make a directory and move files into it.
function mkmv() {
  mkdir -p -- "${@: -1}" && mv -- "$@"
}

complete -A directory mkcd mkcp mkmv
