#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

. "${USR_PATH}/share/bash-completion/bash_completion" >/dev/null 2>&1

COLOUR_BG_DARK_GREY="$(tput setab 8)"
COLOUR_BG_DARK_GREEN="$(tput setab 2)"
STYLE_RESET="$(tput sgr0)"

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
  info="$(fossil branch list 2>/dev/null)" || return $exit
  printf -- "${fmt}" "$(awk '/*/ { print $2 }' - <<< "${info}")"
}

__virtualenv_ps1() {
  local fmt=' (%s)'
  local exit=$?
  case $# in
    0|1)
      fmt="${1:-$fmt}"
      ;;
    *)
      return $exit
  esac
  [[ -n $VIRTUAL_ENV ]] || return
  printf -- "${fmt}" "${VIRTUAL_ENV##*/}"
}

eval "$(duiker magic)"

function is_ssh() {
  [[ -n $SSH_CLIENT ]] || [[ -n $SSH_TTY ]]
}

function is_me() {
  [[ $USER = $LOCAL_USER ]]
}

# Sets a typical PS1 including virtualenv and Git branch.
__prompt() {
  AT_PROMPT=1
  history -a
  __duiker_import
  local git_status fsl_status virtualenv_status
  git_status="$(__git_ps1 'git ᚠ %s')"
  fsl_status="$(__fossil_ps1 'fsl ᚠ %s')"
  virtualenv_status="$(__virtualenv_ps1 '%s')"
  [[ -n $git_status ]] && git_status="${COLOUR_BG_DARK_GREY} ${git_status} ${STYLE_RESET}"
  [[ -n $fsl_status ]] && fsl_status="${COLOUR_BG_DARK_GREY} ${fsl_status} ${STYLE_RESET}"
  [[ -n $virtualenv_status ]] && virtualenv_status="${COLOUR_BG_DARK_GREEN} ${virtualenv_status} ${STYLE_RESET}"
  local status="${git_status}${fsl_status}${virtualenv_status}"
  # Make space for vi mode indicator in Bash 4.4+ and prefix user@host with
  # space if there is status information to show.
  if [[ -n $status || (${BASH_VERSINFO[0]} -ge 4 && ${BASH_VERSINFO[1]} -ge 4) ]]; then
    status="        ${status} "
  fi
  PS1="\[${status}\]"
  ! is_me && PS1="${PS1}\u"
  is_ssh && PS1="${PS1}@\h"
  ! is_me && PS1="${PS1}:"
  PS1="${PS1}\w\n\$ "
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
