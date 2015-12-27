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

# Retrieve information about hosts using <http://ipinfo.io/>.
# Arguments:
#   $@  list of hostnames
# Returns:
#   JSON-formatted DNS and GeoIP information.
nameinfo() {
  [[ -z "${1:-}" ]] && { printf "nameinfo: enter hostname\n" >&2; return 1; }
  for host in "${@}"; do
    # shellcheck disable=SC2046
    ipinfo $(dig +noall +short "${host}")
  done
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

complete -A command halp

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

function cdtemp() {
  builtin cd -- "$(mktemp -d 2>/dev/null || mktemp -d -t tmp)"
}

function swap() {
  local usage='usage: swap FILE1 FILE2

Rename FILE1 to FILE2 and FILE2 to FILE1.'
  if [[ $# -ne 2 ]]; then
    local rc=1
    if [[ ${1:-} == '-h' ]] || [[ ${1:-} == '--help' ]]; then
      printf "%s\n" "${usage}"
      rc=0
    else
      printf "%s\n" "${usage}" >&2
    fi
    return $rc
  fi
  local temp=$(mktemp -t tmp.XXXXX)
  command mv "${1}" "${temp}"
  command mv "${2}" "${1}"
  command mv "${temp}" "${2}"
}

complete -A directory mkcd mkcp mkmv

DATETIME_FORMAT='%Y%m%dT%H%M%S'

function now() {
  date +"${DATETIME_FORMAT}"
}

function utc() {
  date -u +"${DATETIME_FORMAT}"
}
