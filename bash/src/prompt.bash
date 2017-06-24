#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

. "${USR_PATH}/share/bash-completion/bash_completion" >/dev/null 2>&1

_ansi_bg_black_bright="$(tput setab 8)"
_ansi_bg_green_dim="$(tput setab 2)"
_ansi_bg_red_dim="$(tput setab 1)"
_ansi_fg_black_dim="$(tput setaf 0)"
_ansi_reset="$(tput sgr0)"
_ansi_restore_cursor="$(tput rc)"
_ansi_save_cursor="$(tput sc)"

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
  [[ $USER == "${LOCAL_USER}" ]]
}


pos() {
  local pos
  # shellcheck disable=SC2162
  read -d R -p $'\E[6n' -s pos
  printf '%s' "${pos#*[}"
}

row() {
  local IFS row col
  # shellcheck disable=SC2034,SC2162
  IFS=';' read -d R -p $'\E[6n' -s row col
  printf '%s' "${row#*[}"
}


__csr() {
  tput csr 0 "$(($(tput lines) - 3))"
}

# Sets a typical PS1 including virtualenv and Git branch.
__prompt() {
  rc=$?
  AT_PROMPT=1
  history -a
  __duiker_import
  local exit_status git_status fsl_status virtualenv_status
  [[ $rc -ne 0 ]] && exit_status="${_ansi_bg_red_dim}${_ansi_fg_black_dim} ${rc} ${_ansi_reset}"
  git_status="$(__git_ps1 "${_ansi_bg_black_bright} git ᚠ %s ${_ansi_reset}")"
  fsl_status="$(__fossil_ps1 "${_ansi_bg_black_bright} fsl ᚠ %s ${_ansi_reset}")"
  virtualenv_status="$(__virtualenv_ps1 "${_ansi_bg_green_dim} %s ${_ansi_reset}")"
  local status="${exit_status}${git_status}${fsl_status}${virtualenv_status} "
  ! is_me && status="${status}${USER}"
  is_ssh && status="${status}@${HOSTNAME}"
  ! is_me || is_ssh && status="${status}:"
  local statusrow
  status="${status}${PWD}"
  statusrow="$(($(tput lines) - 2))"
  if [[ ${BASH_VERSINFO[0]} -ge 4 ]] && [[ ${BASH_VERSINFO[1]} -ge 4 ]]; then
    bind "set vi-cmd-mode-string \1${_ansi_save_cursor}$(tput cup "${statusrow}" 0)\e[30;43m NORMAL ${_ansi_reset}$(tput el)${status}${_ansi_restore_cursor}\2"
    bind "set vi-ins-mode-string \1${_ansi_save_cursor}$(tput cup "${statusrow}" 0)\e[30;46m INSERT ${_ansi_reset}$(tput el)${status}${_ansi_restore_cursor}\2"
    PS1="\$ "
  else
    PS1="${_ansi_save_cursor}$(tput cup $statusrow 0)$(tput el)${status}${_ansi_restore_cursor}\$ "
  fi
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
trap __csr WINCH

__csr
