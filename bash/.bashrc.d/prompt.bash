#!/bin/bash

#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

. $(brew --prefix)/etc/bash_completion 2>&1 >/dev/null

# Sets a typical PS1 including virtualenv and Git branch. Aligns PS2 (line
# continuation prompt) with $ of preceding PS1.
__prompt() {
  # Mimic \u, \h, and \w. Bash only evaluates these when rendering the prompt,
  # so we cannot use them to calculate the PS2 width.
  local u=${USER}
  local h=${HOSTNAME%%.*}
  local w=${PWD/$HOME\//\~/}
  local venv=
  [[ $VIRTUAL_ENV ]] && venv="[${VIRTUAL_ENV##*/}] "
  PS1="${venv}${u}@${h}:${w}$(__git_ps1)$ "
  # Calculate PS2 width.
  local w_ps1=${#PS1}
  PS2=$(printf "%s" "$(printf " %.0s" $(eval "echo {1..$w_ps1}"))")
}

PROMPT_COMMAND=__prompt
