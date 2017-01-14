printf "$(tput bold; tput setf blue) :: $(tput sgr0)Loading ZshRC...\r"

alias _check='type &>/dev/null'
TMPLOCAL="$HOME/.local/tmp"
mkdir -p "$TMPLOCAL"

# =================
# === OH-MY-ZSH ===

# Path to oh-my-zsh
ZSH="$HOME/.dotfiles/oh-my-zsh/"
ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh-custom/"

# Theme for OMZ
ZSH_THEME='dhg'

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"


# ================ #
# === SOURCING === #

# Arch Linux command-not-found
[ -s '/etc/profile.d/cnf.sh' ] && source '/etc/profile.d/cnf.sh'

# Travis
[ -s "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# Node Version Manager
[ -s "$HOME/.nvm/nvm.sh" ]     && source "$HOME/.nvm/nvm.sh"
[ -s "/usr/share/nvm/nvm.sh" ] && source "/usr/share/nvm/nvm.sh"
_check nvm && NVM_DIR="$HOME/.nvm"

# Ruby Version Manager
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# OhMyZsh!!
plugins=(git npm archlinux systemd virtualenv sudo)
_check virtualenvwrapper.sh && plugins+=(virtualenvwrapper)
_check nvm && plugins+=(nvmauto)
_check rvm && plugins+=(rvm)
source "$ZSH/oh-my-zsh.sh"


# =============== #
# === ALIASES === #

# Alias for hub
_check hub && alias git=hub
_check subl3 && alias subl=subl3

# Alias for reset
alias reset='env reset; source ~/.zshrc'

# Fix GREP_OPTIONS messages
alias grep='\grep $GREP_OPTIONS'
unset GREP_OPTIONS


# === VARIABLES ===

# GCC color setup
export GCC_COLORS='error=01;31:warning=01;33:note=01;36:caret=01;32:locus=01:quote=01'

# MAKEFLAGS for multi-core compilation
_check nproc && export MAKEFLAGS="$MAKEFLAGS -j$(nproc)"

# Export this for 256-color detection
export TERM=xterm-256color

# Add local directories to the PATH
export PATH="$HOME/.bin":"$HOME/.local/bin":"$PATH"

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

# Update mirrors
_check pacman-mirrors \
    && alias pmmir='sudo pacman-mirrors -g' \
    || alias pmmir='sudo reflector -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'

# =========== #
# === END === #
export -U PATH="$PATH"
unalias _check
tput el
