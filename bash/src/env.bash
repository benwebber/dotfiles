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

export CDPATH=:$HOME/src
export EDITOR=vim
export HISTCONTROL=ignorespace
export HISTFILE=$HISTDIR/bash/bash_history.log
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export LESSHISTFILE=$HISTDIR/less/lesshst.log
export MANPAGER=manv
export MYSQL_HISTFILE=$HISTDIR/mysql/mysql_history.log

path put /usr/local/sbin
path put /usr/local/bin
path put "${HOME}/bin"

export PSQL_HISTORY=$HISTDIR/psql/psql_history.log
export REDISCLI_HISTFILE=$HISTDIR/rediscli/rediscli_history.log
