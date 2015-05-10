#!/bin/bash

set -o vi

shopt -s autocd
shopt -s dotglob
shopt -s histappend

export PLATFORM=$(uname)

export EDITOR=vim

case $PLATFORM in
  Darwin)
    export BROWSER=open
    # Avoid invoking Ruby for `brew --prefix`.
    export USR_PATH=/usr/local
    ;;
  Linux)
    export BROWSER=sensible-browser
    export USR_PATH=/usr
    ;;
  *)
    ;;
esac

export HISTSIZE=10000
export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export CDPATH=:$HOME/projects
