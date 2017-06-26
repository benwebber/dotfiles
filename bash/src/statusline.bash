STATUSLINE_HEIGHT=${STATUSLINE_HEIGHT:-2}

_ansi_bg_black_bright="$(tput setab 8)"
_ansi_bg_green_dim="$(tput setab 2)"
_ansi_bg_red_dim="$(tput setab 1)"
_ansi_fg_black_dim="$(tput setaf 0)"
_ansi_reset="$(tput sgr0)"
_ansi_restore_cursor="$(tput rc)"
_ansi_save_cursor="$(tput sc)"


statusline::get_row() {
  local IFS row col
  # shellcheck disable=SC2034,SC2162
  IFS=';' read -d R -p $'\E[6n' -s row col
  printf '%s' "${row#*[}"
}



statusline::get_statusline_row() {
  printf '%s' "$(($(tput lines) - STATUSLINE_HEIGHT))"
}


statusline::set_scroll_region() {
  tput sc
  tput csr 0 "$(($(statusline::get_statusline_row) - 1))"
  tput rc
}


statusline::clear_after() {
  tput sc
  tput cup "$(statusline::get_row)" 0
  tput ed
  tput rc
}


statusline::draw() {
  local row
  local status="${1:-}"
  local mode="${2:-}"
  row="$(statusline::get_statusline_row)"
  if [[ $(statusline::get_row) -ge $(statusline::get_statusline_row) ]]; then
    tput clear
  fi
  statusline::clear_after
  printf '%s' "${_ansi_save_cursor}$(tput cup "${row}" 0)${mode}${status}${_ansi_restore_cursor}"
}


statusline::set_scroll_region_and_draw() {
  statusline::set_scroll_region
  statusline::draw
}


trap statusline::set_scroll_region_and_draw WINCH

statusline::set_scroll_region
