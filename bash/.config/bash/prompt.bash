#require bash
[[ -t 1 ]] || return

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

if command -v duiker >/dev/null 2>&1; then
  eval "$(duiker magic)"
fi

_ansi_reset="\[$(tput sgr0)\]"
_tmux_fg_white='#[fg=colour15]'
_tmux_bg_dark_grey='#[bg=colour238]'
_tmux_bg_bright_green='#[bg=colour118]'
_tmux_reset='#[default]'

__update_tmux_status_line() {
  [[ -z $TMUX ]] && return
  local rc=$1
  local status exit_status fsl_status virtualenv_status
  local git_status=''
  [[ $rc -eq 0 ]] && exit_status='' || exit_status="${_monokai_error_tmux} ${rc} ${_tmux_reset}"
  if command -v __git_ps1 >/dev/null 2>&1; then
    git_status="$(__git_ps1 "${_tmux_bg_dark_grey}${_tmux_fg_white} git ᚠ %s ${_tmux_reset}")"
  fi
  fsl_status="$(__fossil_ps1 "${_tmux_bg_dark_grey}${_tmux_fg_white} fsl ᚠ %s ${_tmux_reset}")"
  virtualenv_status="$(__virtualenv_ps1 "${_tmux_bg_bright_green}${_tmux_fg_white} %s ${_tmux_reset}")"
  status="$(dirs) ${git_status}${fsl_status}${virtualenv_status}${exit_status}"
  tmux set-buffer -b "$(tmux display -p 'tmux::status-right::#D')" "${status}"
  tmux refresh-client -S
}

__prompt() {
  local rc=$?
  local ps1="λ${_ansi_reset} "
  local ps2=".${_ansi_reset} "
  history -a
  command -v __duiker_import >/dev/null 2>&1 && __duiker_import
  __update_tmux_status_line $rc
  if [[ -z $TMUX ]]; then
    ps1="${ps1}\w ${_monokai_magenta_ansi}→${_ansi_reset} "
  fi
  if ! bash::has_vi_mode_string; then
    # Bash does not support `vi-cmd-mode-string` and `vi-ins-mode-string`;
    # colour prompt directly.
    ps1="${_monokai_magenta_ansi}${ps1}"
    ps2="${_monokai_magenta_ansi}${ps2}"
  fi
  PS1=$ps1
  PS2=$ps2
}

PROMPT_COMMAND=__prompt
