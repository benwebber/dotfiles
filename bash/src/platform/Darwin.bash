#-------------------------------------------------------------------------------
# Mac OS X
#-------------------------------------------------------------------------------

export BROWSER=open
export HOMEBREW_CASK_OPTS='--appdir=/Applications'
# Avoid invoking Ruby for `brew --prefix`.
export USR_PATH=/usr/local

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
      path contains "${path}/gnubin" || path insert "${path}/gnubin"
      path -p MANPATH contains "${path}/gnuman" || path -p MANPATH insert "${path}/gnuman"
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
alias gvim=mvim

__load_gnu_utils
