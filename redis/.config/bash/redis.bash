export REDISCLI_HISTFILE="${XDG_DATA_HOME}/redis/history"
[[ -d $(dirname "${REDISCLI_HISTFILE}") ]] || mkdir -p "$(dirname "${REDISCLI_HISTFILE}")"
