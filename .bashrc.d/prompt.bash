#!/bin/bash

#------------------------------------------------------------------------------
# Completions and $PS1
#------------------------------------------------------------------------------

completion_dirs=(
  '~/.bash_completion.d'
  '/etc/bash_completion.d'
  '/usr/local/etc/bash_completion.d'
)
completion_files=(
  'git-prompt.sh'
  'git-completion.bash'
  'tig-completion.bash'
)
for cdir in "${completion_dirs[@]}"; do
  for cfile in "${completion_files[@]}"; do
    if [[ -f "${cdir}/${cfile}" ]]; then
      . "${cdir}/${cfile}"
    fi
  done
done

PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

