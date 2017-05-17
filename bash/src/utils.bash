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
mkcd() {
  mkdir -p -- "$@" && builtin cd -- "$@"
}

# Make a directory and copy files into it.
mkcp() {
  mkdir -p -- "${@: -1}" && cp -- "$@"
}

# Make a directory and move files into it.
mkmv() {
  mkdir -p -- "${@: -1}" && mv -- "$@"
}

cdtemp() {
  builtin cd -- "$(mktemp -d 2>/dev/null || mktemp -d -t tmp)"
}

isabsolute() {
  [[ $1 == /* ]] || [[ $1 == \~/* ]]
}

pypackage() {
  local path="${1}"
  isabsolute "${path}" && { printf "pypackage: path must be relative\n" >&2; return 1; }
  mkdir -p "${path}"
  while IFS= read -r -d $'\0' dir; do
    [[ -f "${dir}/__init__.py" ]] || touch "${dir}/__init__.py"
  done < <(find "${path%%/*}" -type d -print0)
}

swap() {
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

now() {
  # shellcheck disable=SC2048,SC2086
  date +'%Y%m%dT%H%M%S' $*
}

utc() {
  now -u
}

default() {
  [[ -n ${1:-} ]] || { echo 'default <default>' >&2; return 1; }
  grep . || printf '%s\n' "${1}"
}

format() {
  local fmt
  IFS= read -r fmt
  # shellcheck disable=SC2059
  printf "${fmt}\n" "${@}"
}

join_by() {
  local sep="${1:-}"
  tr '\n' ' ' | trim | sed -e 's/[[:space:]]\+/'"${sep}"'/g'
  echo
}

lower() {
  tr '[:upper:]' '[:lower:]'
}

lstrip() {
  sed -e 's/^[[:space:]]*//'
}

random() {
  local idx len text words
  read -r text
  len="$(wc -w <<< "${text}")"
  idx=$((RANDOM % len))
  read -r -a words <<< "${text}"
  echo "${words[$idx]}"
}

replace() {
  [[ -n ${1:-} && -n ${2:-} ]] || { echo 'replace <old> <new>' >&2; return 1; }
  sed -e 's/'"${1}"'/'"${2}"'/g'
}

rstrip() {
  sed -e 's/[[:space:]]*$//'
}

trim() {
  lstrip | rstrip
}

upper() {
  tr '[:lower:]' '[:upper:]'
}
