#!/bin/bash

set -o vi

shopt -s autocd
shopt -s dotglob
shopt -s histappend

dotfiles=$(dirname "$(readlink "${BASH_SOURCE[0]}")")
dotfiles_bin="${dotfiles}/bin"

export EDITOR=vim
export HISTSIZE=10000
export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export PATH=$HOME/bin:"${dotfiles_bin}":/usr/local/bin:$PATH
export CDPATH=:$HOME/projects

__load() {
  local dir="${1}"
  if [[ -d "${dir}" ]]; then
    for f in "${dir}"/*.bash; do
      [[ -r "${f}" ]] && . "${f}"
    done
  fi
}

__load ~/.bashrc.d

[[ -r ~/.bashrc_local ]] && . ~/.bashrc_local
