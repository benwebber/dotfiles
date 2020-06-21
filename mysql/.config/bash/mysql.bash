export MYSQL_HISTFILE="${XDG_DATA_HOME}/mysql/history"
[[ -d $(dirname "${MYSQL_HISTFILE}") ]] || mkdir -p "$(dirname "${MYSQL_HISTFILE}")"
