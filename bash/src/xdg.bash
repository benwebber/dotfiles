[[ -z $XDG_CACHE_HOME ]] && export XDG_CACHE_HOME="${HOME}/.cache"
[[ -z $XDG_CONFIG_HOME ]] && export XDG_CONFIG_HOME="${HOME}/.config"
[[ -z $XDG_DATA_HOME ]] && export XDG_DATA_HOME="${HOME}/.local/share"
[[ -z $XDG_BIN_HOME ]] && export XDG_BIN_HOME="${HOME}/.local/bin"

export LEDGER_FILE="${XDG_DATA_HOME}/hledger/hledger.journal"
