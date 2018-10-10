[[ -z $XDG_CACHE_HOME ]] && export XDG_CACHE_HOME="${HOME}/.cache"
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z $XDG_DATA_HOME ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z $XDG_BIN_HOME ]] && export XDG_BIN_HOME="${HOME}/.local/bin"

export INPUTRC="${XDG_CONFIG_HOME}/readline/inputrc"
export LEDGER_FILE="${XDG_DATA_HOME}/hledger/hledger.journal"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"
