s() {
  [[ -z "${1:-}" ]] && {
    printf "%s: %s\n" "${FUNCNAME[0]}" 'specify a command' >&2
    return 1
  }
  local cmd="s${1:-}"
  shift
  $cmd "${@}"
}

_s() {
  COMPREPLY=()

  local cmd cur func prev spec script
  local -a scripts
  local -r func_re='-F ([a-zA-Z0-9_]+)'

  cur="${COMP_WORDS[COMP_CWORD]}"    # pointer to current word
  prev="${COMP_WORDS[COMP_CWORD-1]}" # pointer to previous word

  scripts=(cal dig)

  case $COMP_CWORD in
    1)
      # Complete script commands.
      COMPREPLY=($(compgen -W "${scripts[*]}" -- "${cur}"))
      ;;
    2)
      # Pass onto command completion.
      script="${prev}"
      _completion_loader "${script}"
      spec=$(complete -p "${script}")
      # Remove 's' from the command line.
      cmd="${COMP_LINE#$1 }"
      COMP_WORDS=($cmd)
      # Reduce COMP_CWORD to trick the script command's completion function.
      COMP_CWORD=$((COMP_CWORD - 1))
      # Call the script command's completion.
      [[ $spec =~ $func_re ]]
      func="${BASH_REMATCH[1]}"
      eval "${func} ${cmd}"
      ;;
    *)
      # Should never reach here.
      printf "invalid completion state\n" >&2
      COMPREPLY=()
      ;;
  esac
}

complete -F _s s
