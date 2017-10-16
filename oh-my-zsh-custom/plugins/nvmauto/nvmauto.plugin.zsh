## nvm automatic activation.

function _nvma_checkparent {
  # Find the closest .nvm file...
  local searchdir="$(readlink -f .)"
  while [ "$searchdir" != '/' ]; do
    if [ -f "$searchdir/$1" ]; then
      echo "$searchdir/$1"
      return 0
    fi

    searchdir="$(dirname "$searchdir")"
  done

  return 1
}

function _nvma_nvmuse_cwd {
  if [[ -n "$nvmrc" ]] || _nvma_checkparent package.json >/dev/null; then
    nvm use . &>/dev/null
    NVMA_PROMPT=yes
  else
    NVMA_PROMPT=
  fi
}

if ! (( $chpwd_functions[(I)_nvma_nvmuse_cwd] )); then
  chpwd_functions+=(_nvma_nvmuse_cwd)
fi

NVMA_PROMPT=yes
_nvma_nvmuse_cwd
