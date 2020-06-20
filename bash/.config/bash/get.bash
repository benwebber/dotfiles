get() {
  local OPTIND
  local options
  options="$(help set | awk 'NR==1 { options = $3; gsub(/[^a-zA-Z]/, "", options); print options "o:"}')"

  while getopts "$options" opt; do
    case $opt in
      o)
        if [[ $SHELLOPTS == *${OPTARG}* ]]; then
          # TODO: handle partial matches
          echo "-o ${OPTARG}"
          return
        fi
        echo "+o ${OPTARG}"
        return 1
        ;;
      *)
        if [[ $- == *${opt}* ]]; then
          echo "-${opt}"
          return
        fi
        echo "+${opt}"
        return 1
        ;;
    esac
  done
}
