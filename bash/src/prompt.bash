#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

. "${USR_PATH}/share/bash-completion/bash_completion" >/dev/null 2>&1

__fossil_ps1() {
  local info
  local fmt=' (%s)'
  local exit=$?
  case $# in
    0|1)
      fmt="${1:-$fmt}"
      ;;
    *)
      return $exit
      ;;
  esac
  info="$(fossil info 2>/dev/null)"
  [[ $? -gt 0 ]] && return
  printf -- "${fmt}" "$(awk -F':[ ]+' '/tags/ { print $2 }' - <<< "${info}")"
}

eval "$(duiker magic)"

# Sets a typical PS1 including virtualenv and Git branch.
__prompt() {
  AT_PROMPT=1
  history -a
  __duiker_import
  local venv=
  [[ $VIRTUAL_ENV ]] && venv="\[\e[42m ${VIRTUAL_ENV##*/} \e[m\]"
  local git_status fsl_status
  git_status="$(__git_ps1 ' git ᚠ %s ')"
  [[ -n $git_status ]] && git_status="\[\e[100m${git_status}\e[m\]"
  fsl_status="$(__fossil_ps1 ' fsl ᚠ %s ')"
  [[ -n $fsl_status ]] && fsl_status="\[\e[100m${fsl_status}\e[m\]"
  local status="${git_status}${fsl_status}${venv}"
  # Prefix user@host with space if there is status information to show, or if
  # we are using Bash 4.4+ with vi mode indicators.
  if [[ -n $status || (${BASH_VERSINFO[0]} -ge 4 && ${BASH_VERSINFO[1]} -ge 4) ]]; then
    status="${status} "
  fi
  PS1="${status}\u@\h:\w$ "
}

PROMPT_COMMAND=__prompt

# Call halp using a question mark.
__help() {
  [[ -n $COMP_LINE ]] && return
  [[ -z $AT_PROMPT ]] && return
  unset AT_PROMPT
  if [[ $BASH_COMMAND == *\? ]] && [[ $BASH_COMMAND != *\$\? ]] && [[ $BASH_COMMAND != *-\? ]]; then
    halp "${BASH_COMMAND%?}"
  fi
}

trap __help DEBUG
