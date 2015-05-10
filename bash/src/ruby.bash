#-------------------------------------------------------------------------------
# Ruby
#-------------------------------------------------------------------------------

export PATH=~/.gem/ruby/2.2.0/bin:$PATH

__load_chruby() {
  local chrubylib="${USR_PATH}/opt/chruby/share/chruby/chruby.sh"
  [[ -r "${chrubylib}" ]] && . "${chrubylib}"
}

__load_chruby
