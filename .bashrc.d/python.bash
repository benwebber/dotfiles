#!/bin/bash

#-------------------------------------------------------------------------------
# Python
#-------------------------------------------------------------------------------

# Configure virtualenv
export PROJECT_HOME=$HOME/projects
export WORKON_HOME=$HOME/.virtualenvs

virtualenvwrapper="/usr/local/bin/virtualenvwrapper.sh"

if [ -f $virtualenvwrapper ]; then
  source $virtualenvwrapper
fi

