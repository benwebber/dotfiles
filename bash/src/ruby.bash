#-------------------------------------------------------------------------------
# Ruby
#-------------------------------------------------------------------------------

export PATH=~/.gem/ruby/2.2.0/bin:$PATH

__load_chruby() {
  for lib in ${USR_PATH}/opt/chruby/share/chruby/*; do
    [[ -r "${lib}" ]] && . "${lib}"
  done
}

__load_chruby
