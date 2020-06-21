set -o vi

if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
  shopt -s autocd
fi

if [[ $(uname -s) == 'Darwin' ]]; then
  USR_PATH=/usr/local
else
  USR_PATH=/usr
fi

shopt -s cdspell
shopt -s checkhash
shopt -s dotglob
shopt -s extglob
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -u sourcepath

export CDPATH=:$HOME/src
export EDITOR=vim
export HISTCONTROL=ignorespace
export HISTFILE="${XDG_DATA_HOME}/bash/history"
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export MANPAGER=manv
export PATH="${HOME}/bin:${HOME}/.local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"

bash::has_vi_mode_string() {
  [[ ${BASH_VERSINFO[0]} -ge 5 ]] || { [[ ${BASH_VERSINFO[0]} -ge 4 ]] && [[ ${BASH_VERSINFO[1]} -ge 4 ]]; }
}

command_not_found_handle() {
  local cmd
  cmd="${1}"
  if [[ $cmd == *\? ]] && [[ -t 1 ]]; then
    halp "${cmd%?}"
  else
    printf -- '-bash: %s: command not found\n' "${cmd}" >&2
  fi
  return 127
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
