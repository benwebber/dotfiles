#!/bin/bash

shopt -s autocd
shopt -s dotglob
shopt -s histappend

dotfiles=$(dirname "$(readlink "${BASH_SOURCE[0]}")")
dotfiles_bin="${dotfiles}/bin"

export EDITOR=vim
export HISTSIZE=10000
export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export PATH=~/bin:"${dotfiles_bin}":/usr/local/bin:$PATH

__load() {
  local dir="${1}"
  if [[ -d "${dir}" ]]; then
    for f in "${dir}"/*; do
      [[ -r "${f}" ]] && . "${f}"
    done
  fi
}

__load ~/.bashrc.d
