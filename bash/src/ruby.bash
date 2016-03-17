#-------------------------------------------------------------------------------
# Ruby
#-------------------------------------------------------------------------------

path contains ~/.gem/ruby/2.2.0/bin || path insert ~/.gem/ruby/2.2.0/bin

__load_chruby() {
  for lib in ${USR_PATH}/opt/chruby/share/chruby/*; do
    [[ -r "${lib}" ]] && . "${lib}"
  done
}

__load_chruby
