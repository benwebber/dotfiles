#-------------------------------------------------------------------------------
# Python
#-------------------------------------------------------------------------------

# Configure virtualenv
export PROJECT_HOME=$HOME/src
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_SCRIPT="$(command -v virtualenvwrapper.sh)"
export PIPSI_HOME=${WORKON_HOME}
export PYTHONDONTWRITEBYTECODE=1

[[ -f $VIRTUALENVWRAPPER_SCRIPT ]] && . "${VIRTUALENVWRAPPER_SCRIPT/%.sh/_lazy.sh}"

revirtualenv() {
  virtualenv --relocatable "${WORKON_HOME}/${1}"
}

complete -o default -o nospace -F _virtualenvs revirtualenv

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - --no-rehash)"
fi
