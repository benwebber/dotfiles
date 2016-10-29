#-------------------------------------------------------------------------------
# Python
#-------------------------------------------------------------------------------

# Configure virtualenv
export PROJECT_HOME=$HOME/src
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_SCRIPT="$(command -v virtualenvwrapper.sh)"
export PIPSI_HOME=${WORKON_HOME}
export PIPSI_BIN_DIR=${HOME}/bin
export PYTHONDONTWRITEBYTECODE=1

[[ -f $VIRTUALENVWRAPPER_SCRIPT ]] && . "${VIRTUALENVWRAPPER_SCRIPT/%.sh/_lazy.sh}"

revirtualenv() {
  virtualenv --relocatable "${WORKON_HOME}/${1}"
}

complete -o default -o nospace -F _virtualenvs revirtualenv
