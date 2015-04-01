# === OH-MY-ZSH ===

# Path to oh-my-zsh
ZSH="$HOME/.dotfiles/oh-my-zsh/"
ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh-custom/"

# Theme for OMZ
ZSH_THEME='dhg'

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git npm archlinux systemd virtualenv)
type virtualenvwrapper.sh &>/dev/null && \
    plugins+=(virtualenvwrapper)

source "$ZSH/oh-my-zsh.sh"


# ================ #
# === SOURCING === #

# Arch Linux command-not-found
[ -f '/etc/profile.d/cnf.sh' ] && source '/etc/profile.d/cnf.sh'

# Travis
[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"


# =============== #
# === ALIASES === #

# Alias for hub
type hub &>/dev/null && alias git=hub
type subl3 &>/dev/null && alias subl=subl3

# Alias for reset
alias reset='env reset; source ~/.zshrc'

# Fix GREP_OPTIONS messages
alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Fix problems with node-gyp and python3
alias npm='PYTHON=python2 npm'


# === VARIABLES ===

# GCC color setup
export GCC_COLORS='error=01;31:warning=01;33:note=01;36:caret=01;32:locus=01:quote=01'

# MAKEFLAGS for multi-core compilation
type nproc &>/dev/null && export MAKEFLAGS="$MAKEFLAGS -j$(nproc)"

# Export this for 256-color detection
export TERM=xterm-256color

# Add local directories to the PATH
export PATH="$HOME/.bin":"$HOME/.local/bin":"$PATH"

# For the love of everything, use nano!!
export EDITOR=nano


# ======================= #
# === PACKAGE MANAGER === #

# Pacaur package manager
type pacaur &>/dev/null && {
    alias pm=pacaur
    alias pmnc='pacaur --noconfirm --noedit'
    alias pmupd='pacaur -Syu --noconfirm --noedit'

    alias pmin='pmnc -S'  # PM Install
    alias pmrm='pmnc -R'  # PM Remove
    alias pmsr='pmnc -Ss' # PM Search
}

# Update mirrors
type pacman-mirrors &>/dev/null \
    && alias pmmir='sudo pacman-mirrors -g' \
    || alias pmmir='sudo reflector -l 200 -p http --sort rate --save /etc/pacman.d/mirrorlist'
