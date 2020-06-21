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
  find -L "${XDG_CONFIG_HOME}/bash" -iname '*.bash' -print0 -type f \
    | xargs -0 awk -v DIR="${XDG_CONFIG_HOME}/bash" "${__DOTFILES_GRAPH}" \
    | tsort \
    | __dotfiles_tac \
    | tail -n +2
}

__dotfiles_tac() {
  tac 2>/dev/null || tail -r
}

__dotfiles_boot
