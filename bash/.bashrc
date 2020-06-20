[[ -z $XDG_CACHE_HOME ]] && export XDG_CACHE_HOME="${HOME}/.cache"
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z $XDG_DATA_HOME ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z $XDG_BIN_HOME ]] && export XDG_BIN_HOME="${HOME}/.local/bin"

read -r -d '' __DOTFILES_GRAPH <<'EOF'
FNR == 1 {
  print FILENAME, "__placeholder__";
}

/^#require/ {
  print FILENAME, DIR "/" $2 ".bash";
}
EOF

__dotfiles_boot() {
  while read -r module; do
    # shellcheck disable=SC1090
    . "${module}"
  done < <(__dotfiles_iter_modules)
}

__dotfiles_iter_modules() {
  local _globstar
  _globstar="$(shopt -p globstar)"
  shopt -s globstar
  local modules=(${XDG_CONFIG_HOME}/bash/**/*.bash)
  if [[ ! -e "${modules[0]}" ]]; then
    $_globstar
    return
  fi
  awk -v DIR="${XDG_CONFIG_HOME}/bash" "${__DOTFILES_GRAPH}" "${modules[@]}" | tsort | __dotfiles_tac | tail -n +2
  $_globstar
}

__dotfiles_tac() {
  tac 2>/dev/null || tail -r
}

__dotfiles_boot
