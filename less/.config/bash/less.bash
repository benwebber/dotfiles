export LESSHISTFILE="${XDG_DATA_HOME}/less/history"
[[ -d $(dirname "${LESSHISTFILE}") ]] || mkdir -p "$(dirname "${LESSHISTFILE}")"
