__OS="$(uname -s)"

os::is_linux() {
  [[ $__OS == 'Linux' ]]
}

os::is_mac() {
  [[ $__OS == 'Darwin' ]]
}

os::path::is_absolute() {
  [[ $1 == /* ]] || [[ $1 == \~/* ]]
}
