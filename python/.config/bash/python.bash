#require os
#require utils

export WORKON_HOME="${XDG_DATA_HOME}/virtualenvs"
export VIRTUALENVWRAPPER_SCRIPT="$(command -v virtualenvwrapper.sh)"
export PYTHONDONTWRITEBYTECODE=1

[[ -f $VIRTUALENVWRAPPER_SCRIPT ]] && . "${VIRTUALENVWRAPPER_SCRIPT/%.sh/_lazy.sh}"

if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - --no-rehash)"
fi


pypackage() {
  local path="${1}"
  [[ -n "${path}" ]] || { die 'pypackage: specify a relative path'; return $?; }
  os::path::is_absolute "${path}" && { die 'pypackage: path must be relative'; return $?; }
  mkdir -p "${path}"
  while IFS= read -r -d $'\0' dir; do
    [[ -f "${dir}/__init__.py" ]] || touch "${dir}/__init__.py"
  done < <(find "${path%%/*}" -type d -print0)
}
