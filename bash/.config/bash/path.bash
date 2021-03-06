path() {
  # shellcheck disable=SC2016
  local usage='usage: path [-h] [-p <variable>] <command> [args]

Modify $PATH with ease.

options:

  -h              show this page
  -p <variable>   modify <variable> instead of $PATH

commands:

  at <index>        return the path at <index> (0-indexed)
  contains <path>   check if $PATH contains <path>
  delete <delete>   delete <path> from $PATH
  first             return the first path in $PATH
  help              show this page
  index <path>      return the 0-indexed position of <path> in $PATH
  insert <path>     insert <path> at the beginning of $PATH
  last              return the last path in $PATH
  length            return the number of paths in $PATH
  push <path>       append <path> to the end of $PATH
  put <path>        insert <path> if it does not exist
'
  local pathvar=PATH
  local OPTIND

  while getopts 'hp:' opt; do
    case $opt in
      h)
        printf "%s" "${usage}"
        return
        ;;
      p)
        pathvar=${OPTARG}
        ;;
      *)
        printf "%s" "${usage}"
        return 1
        ;;
    esac
  done
 
  shift $((OPTIND - 1))

  # large number of false positives due to positions of array operations
  # shellcheck disable=SC2128
  # required to indirectly dereference variable
  # shellcheck disable=SC1066
  case $1 in
    at)
      path=(${!pathvar//:/ })
      # Given array `arr` with length `n`, fail if user tries to access
      # `arr[m]`, where m >= n.
      local max_index=${#path[@]}
      (( max_index - 1))
      [[ $2 -ge $max_index ]] && return 1
      printf "%s\n" "${path[$2]}"
      ;;
    contains)
      [[ ":${!pathvar}:" == *:${2}:* ]]
      ;;
    delete)
      echo "${2}"
      path=":${!pathvar}"
      path="${path/:${2}/}"
      export $pathvar="${path#:}"
      ;;
    first)
      printf "%s\n" "${!pathvar%%:*}"
      ;;
    help)
      printf "%s\n" "${usage}"
      ;;
    index)
      path=(${!pathvar//:/ })
      for ((i=0; i < "${#path[@]}"; i++)); do
        if [[ ${path[$i]} == "${2}" ]]; then
          printf "%s\n" $i
          return
        fi
      done
      return 1
      ;;
    insert)
      export $pathvar="${2}:${!pathvar}"
      ;;
    last)
      printf "%s\n" "${!pathvar##*:}"
      ;;
    length)
      path=(${!pathvar//:/ })
      printf "%s\n" "${#path[@]}"
      ;;
    push)
      export $pathvar="${!pathvar}:${2}"
      ;;
    put)
      [[ ":${!pathvar}:" == *:${2}:* ]] || export $pathvar="${2}:${!pathvar}"
      ;;
    *)
      printf "%s\n" "${!pathvar//:/$'\n'}"
      ;;
  esac
}
