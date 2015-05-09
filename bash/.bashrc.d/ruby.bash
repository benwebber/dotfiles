#-------------------------------------------------------------------------------
# Ruby
#-------------------------------------------------------------------------------

export PATH=~/.gem/ruby/2.2.0/bin:$PATH

chrubylib="$(brew --prefix)/opt/chruby/share/chruby/chruby.sh"

[[ -r "${chrubylib}" ]] && . "${chrubylib}"
