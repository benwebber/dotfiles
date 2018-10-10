PROGRAM=$(basename $0)

usage() {
  cat<<EOF


Usage:
  ${PROGRAM}

Options:
  -h  show this screen and exit
EOF
}

main() {
  while getopts 'h' opt; do
    case $opt in
      h)
        usage
        return
        ;;
      *)
        usage
        return 1
        ;;
    esac
  done

  shift $(( OPTIND-1 ))

}

main "${@}"
