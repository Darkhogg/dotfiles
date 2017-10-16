## nvm automatic activation.

function _nvma_checkparent {
  # Find the closest file...
  local searchdir="$(readlink -f .)"
  while [ "$searchdir" != '/' ]; do
    if [ -f "$searchdir/$1" ]; then
      echo "$searchdir/$1"
      return 0
    fi

    searchdir="$(readlink -f "$searchdir/..")"
  done

  return 1
}

function _nvma_nvmuse_cwd {
  if _nvma_checkparent package.json &>/dev/null; then
    local nvmrc="$(_nvma_checkparent .nvmrc)"

    if [[ -n $nvmrc ]]; then
      nvm use $(<"$nvmrc") &>/dev/null
      NVMA_PROMPT=yes
    fi
  else
    if [[ -n $NVMA_PROMPT ]]; then
      nvm use system &>/dev/null
    fi
    NVMA_PROMPT=
  fi
}

if ! (( $chpwd_functions[(I)_nvma_nvmuse_cwd] )); then
  chpwd_functions+=(_nvma_nvmuse_cwd)
fi

NVMA_PROMPT=yes
_nvma_nvmuse_cwd
