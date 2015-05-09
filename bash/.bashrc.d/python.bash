#-------------------------------------------------------------------------------
# Python
#-------------------------------------------------------------------------------

# Configure virtualenv
export PROJECT_HOME=$HOME/projects
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_SCRIPT="$(command -v virtualenvwrapper.sh)"
export PIPSI_HOME=${WORKON_HOME}
export PIPSI_BIN_DIR=${HOME}/bin

[[ -f $VIRTUALENVWRAPPER_SCRIPT ]] && . "${VIRTUALENVWRAPPER_SCRIPT/%.sh/_lazy.sh}"
