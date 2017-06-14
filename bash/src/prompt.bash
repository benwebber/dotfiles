#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

. "${USR_PATH}/share/bash-completion/bash_completion" >/dev/null 2>&1

__fossil_ps1() {
  local info
  info="$(fossil info 2>/dev/null)"
  [[ $? -gt 0 ]] && return
  printf ' (%s)' "$(awk -F':[ ]+' '/tags/ { print $2 }' - <<< "${info}")"
}

# Sets a typical PS1 including virtualenv and Git branch.
__prompt() {
  AT_PROMPT=1
  history -a
  local venv=
  [[ $VIRTUAL_ENV ]] && venv="[${VIRTUAL_ENV##*/}] "
  PS1="${venv}\u@\h:\w$(__git_ps1)$(__fossil_ps1)$ "
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
