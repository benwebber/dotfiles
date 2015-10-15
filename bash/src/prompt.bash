#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

. "${USR_PATH}/share/bash-completion/bash_completion" >/dev/null 2>&1

# Sets a typical PS1 including virtualenv and Git branch.
__prompt() {
  history -a
  local venv=
  [[ $VIRTUAL_ENV ]] && venv="[${VIRTUAL_ENV##*/}] "
  PS1="${venv}\u@\h:\w$(__git_ps1)$ "
}

PROMPT_COMMAND=__prompt
