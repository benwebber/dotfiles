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

[[ -d "${HISTDIR}/bash" ]] || mkdir -p "${HISTDIR}/bash"
[[ -d "${HISTDIR}/less" ]] || mkdir -p "${HISTDIR}/less"
[[ -d "${HISTDIR}/rediscli" ]] || mkdir -p "${HISTDIR}/rediscli"

export CDPATH=:$HOME/src
export EDITOR=vim
export HISTCONTROL=ignorespace
export HISTFILE=$HISTDIR/bash/bash_history.log
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LESSHISTFILE=$HISTDIR/less/lesshst.log
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export REDISCLI_HISTFILE=$HISTDIR/rediscli/rediscli_history.log
