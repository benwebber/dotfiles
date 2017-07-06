#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

. "${USR_PATH}/share/bash-completion/bash_completion" >/dev/null 2>&1

_monokai_error_tmux='#[bg=colour89,fg=colour219]'
_monokai_magenta_ansi="\[$(tput setaf 161)\]"

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

is_ssh() {
  [[ -n $SSH_CLIENT ]] || [[ -n $SSH_TTY ]]
}

is_me() {
  [[ $USER == "${LOCAL_USER}" ]]
}

_ansi_reset="\[$(tput sgr0)\]"
_tmux_fg_white='#[fg=colour15]'
_tmux_bg_dark_grey='#[bg=colour238]'
_tmux_bg_bright_green='#[bg=colour118]'
_tmux_reset='#[default]'

__update_tmux_status_line() {
  [[ -z $TMUX ]] && return
  local rc=$1
  local status exit_status fsl_status git_status virtualenv_status
  [[ $rc -eq 0 ]] && exit_status='' || exit_status="${_monokai_error_tmux} ${rc} ${_tmux_reset}"
  git_status="$(__git_ps1 "${_tmux_bg_dark_grey}${_tmux_fg_white} git ᚠ %s ${_tmux_reset}")"
  fsl_status="$(__fossil_ps1 "${_tmux_bg_dark_grey}${_tmux_fg_white} fsl ᚠ %s ${_tmux_reset}")"
  virtualenv_status="$(__virtualenv_ps1 "${_tmux_bg_bright_green}${_tmux_fg_white} %s ${_tmux_reset}")"
  status="${git_status}${fsl_status}${virtualenv_status}${exit_status}"
  [[ -n $status ]] && status="$(dirs) ${status}" || status="$(dirs)"
  tmux set -g status-right-length "${#status}"
  tmux set -g status-right "${status}"
}

__prompt() {
  rc=$?
  AT_PROMPT=1
  history -a
  __duiker_import
  __update_tmux_status_line $rc
  if [[ ${BASH_VERSINFO[0]} -ge 4 ]] && [[ ${BASH_VERSINFO[1]} -ge 4 ]]; then
    # If supported, readline will colour the prompt to indicate input mode (see
    # .inputrc).
    PS1="λ${_ansi_reset} "
    PS2=".${_ansi_reset} "
  else
    PS1="${_monokai_magenta_ansi}λ${_ansi_reset} "
    PS2="${_monokai_magenta_ansi}.${_ansi_reset} "
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
