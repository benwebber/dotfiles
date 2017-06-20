#!/bin/bash

set -o vi

if [[ "${BASH_VERSINFO[0]}" -ge 4 ]]; then
  shopt -s autocd
fi
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
export PATH="${HOME}/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
export PSQL_HISTORY=$HISTDIR/psql/psql_history.log
export REDISCLI_HISTFILE=$HISTDIR/rediscli/rediscli_history.log
