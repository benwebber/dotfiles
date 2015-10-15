#!/bin/bash

set -o vi

shopt -s autocd
shopt -s cdspell
shopt -s checkhash
shopt -s dotglob
shopt -s extglob
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -u sourcepath

HISTDIR=$HOME/.history

[[ -d $HISTDIR ]] || mkdir "${HISTDIR}"

export CDPATH=:$HOME/src
export EDITOR=vim
export HISTCONTROL=ignorespace
export HISTFILE=$HISTDIR/.bash_history
export HISTSIZE=
export HISTFILESIZE=
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LESSHISTFILE=$HISTDIR/.lesshst
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
