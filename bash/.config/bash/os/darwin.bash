#require os
#require path

os::is_mac || return

export BROWSER=open

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
    path put "${path}/gnubin"
    path -p MANPATH put "${path}/gnuman"
  done
}

__load_gnu_utils

unset -f update_terminal_cwd
