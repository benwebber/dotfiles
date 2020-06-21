export PSQL_HISTORY="${XDG_DATA_HOME}/postgresql/history"
[[ -d $(dirname "${PSQL_HISTORY}") ]] || mkdir -p "$(dirname "${PSQL_HISTORY}")"
