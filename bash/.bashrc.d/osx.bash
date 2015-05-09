#-------------------------------------------------------------------------------
# Mac OS X
#-------------------------------------------------------------------------------

[[ $(uname) != 'Darwin' ]] && return

export HOMEBREW_CASK_OPTS='--appdir=/Applications'

# Use GNU tools without the g prefix
__load_gnu_utils() {
  local path
  local package
  local packages=(
    'coreutils'
    'gnu-sed'
    'gnu-tar'
  )
  for package in "${packages[@]}"; do
    path="/usr/local/opt/${package}/libexec"
    if [[ -d $path ]]; then
      export PATH="${path}/gnubin:${PATH}"
      export MANPATH="${path}/gnuman:${MANPATH}"
    fi
  done
}

# Function to remove a Homebrew package and all its dependencies
brew_clean() {
  for formula in "$@"; do
    echo "Removing ${formula} and dependencies..."
    brew uninstall "${formula}"
    if [ "$(brew deps "${formula}")" ]; then
      # orphaned packages && formula dependencies
      brew uninstall "$(join <(brew leaves) <(brew deps "${formula}"))"
    fi
  done
}

alias 'brew-clean'=brew_clean

__load_gnu_utils
