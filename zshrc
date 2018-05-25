alias _check='type &>/dev/null'
TMPLOCAL="$HOME/.local/tmp"
mkdir -p "$TMPLOCAL"

# =================
# === OH-MY-ZSH ===

# Path to oh-my-zsh
ZSH="$HOME/.dotfiles/oh-my-zsh/"
ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh-custom/"

# Theme for OMZ
ZSH_THEME='spaceship'
SPACESHIP_PROMPT_DEFAULT_SUFFIX='  '

DISABLE_AUTO_UPDATE=true
COMPLETION_WAITING_DOTS=true


# ================ #
# === SOURCING === #

# Arch Linux command-not-found
[ -s '/etc/profile.d/cnf.sh' ] && source '/etc/profile.d/cnf.sh'

# Travis
[ -s "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# Node Version Manager
NVM_DIR="$HOME/.nvm"
[ -s "$HOME/.nvm/nvm.sh" ]     && source "$HOME/.nvm/nvm.sh"
[ -s "/usr/share/nvm/nvm.sh" ] && source "/usr/share/nvm/nvm.sh"
_check nvm || NVM_DIR=


# OhMyZsh!!
plugins=(git npm archlinux systemd virtualenv sudo)
_check virtualenvwrapper.sh && plugins+=(virtualenvwrapper)
_check nvm && plugins+=(nvmauto)
source "$ZSH/oh-my-zsh.sh"
plugins+=(syntax-highlighting) # must be last

# ===================== #
# === THEME OPTIONS === #

SPACESHIP_PROMPT_ORDER=(
  time
  host user dir
  git #hg
  package
  node
  #ruby elixir xcode swift golang php
  rust
  #haskell julia
  docker
  aws
  venv
  #conda pyenv dotnet ember
  kubecontext
  exec_time line_sep battery
  #vi_mode
  jobs exit_code char
)

SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_PREFIXES_SHOW=false
SPACESHIP_CHAR_COLOR_SUCCESS=white

SPACESHIP_USER_SHOW=always
SPACESHIP_USER_COLOR=green

SPACESHIP_DIR_COLOR=blue
SPACESHIP_DIR_TRUNC=0

SPACESHIP_HOST_COLOR=yellow
SPACESHIP_HOST_COLOR_SSH=yellow

SPACESHIP_GIT_STATUS_COLOR=gray

SPACESHIP_EXEC_TIME_COLOR=black
SPACESHIP_EXEC_TIME_ELAPSED=3

SPACESHIP_EXIT_CODE_SHOW=true


# =============== #
# === ALIASES === #

# mkcd function
function mkcd () {
  mkdir -p -- "$1" \
  && cd -P -- "$1"
}

# alias for hub
_check hub && alias git=hub
_check subl3 && alias subl=subl3

# alias for reset
alias reset='\reset; source ~/.zshrc'

# fix GREP_OPTIONS messages
alias grep='\grep $GREP_OPTIONS'
unset GREP_OPTIONS

# aliases for webtask/wiredtiger
alias wiredtiger='\wt'
alias wt='webtask'

# === VARIABLES ===

# GCC color setup
export GCC_COLORS='error=01;31:warning=01;33:note=01;36:caret=01;32:locus=01:quote=01'

# MAKEFLAGS for multi-core compilation
_check nproc && export MAKEFLAGS="$MAKEFLAGS -j$(nproc)"

# Export this for 256-color detection
export TERM=xterm-256color

# Add local directories to the PATH
export PATH="$HOME/.bin":"$HOME/.gem/ruby/2.2.0/bin":"$HOME/.local/bin":"$PATH"

# For the love of everything, use nano!!
export VISUAL=nano
export EDITOR="$VISUAL"

# Hack for Aseprite AUR package
export ASEPRITE_ACCEPT_EULA=yes

# ======================= #
# === PACKAGE MANAGER === #

# Pacaur package manager
_check pacaur && {
    alias pm=pacaur
    alias pmnc='pm --noconfirm --noedit'
    alias pmupd='pmnc -Syu'

    alias pmin='pmnc -S'  # PM Install
    alias pmrm='pmnc -R'  # PM Remove
    alias pmsr='pmnc -Ss' # PM Search

    alias pmchk='checkupdates'
    alias pmchkn='pmchk | wc -l'

    _check pacman-mirrors \
        && alias pmmir='sudo pacman-mirrors -g' \
        || alias pmmir='sudo reflector -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
}

# Apt-Get package manager
_check apt-get && {
    alias pm='sudo apt-get'
    alias pmnc='pm -y --no-install-recommends'
    alias pmupd='pmnc update && pmnc upgrade'

    alias pmin='pmnc install' # PM Install
    alias pmrm='pmnc remove' # PM Remove
    alias pmsr='apt-cache search' # PM Search
}

# =========== #
# === END === #
export -U PATH="$PATH"
unalias _check
