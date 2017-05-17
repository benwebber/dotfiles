get() {
  local OPTIND
  local options="$(help set | head -n1 | cut -d' ' -f3)"
  options="${options#[-}"
  options="${options%]}"
  options="${options}o:"

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
