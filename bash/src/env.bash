#!/bin/bash

set -o vi

shopt -s autocd
shopt -s dotglob
shopt -s histappend

export EDITOR=vim

export HISTSIZE=10000
export HISTCONTROL=ignorespace
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
export CDPATH=:$HOME/projects
