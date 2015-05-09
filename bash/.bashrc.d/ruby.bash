#-------------------------------------------------------------------------------
# Ruby
#-------------------------------------------------------------------------------

export PATH=~/.gem/ruby/2.2.0/bin:$PATH

__load_chruby() {
  local chrubylib="$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"
  [[ -r "${chrubylib}" ]] && . "${chrubylib}"
}

__load_chruby
