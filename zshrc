printf "$(tput bold; tput setf blue) :: $(tput sgr0)Loading ZshRC...\r"

alias _check='type &>/dev/null'

# =================
# === OH-MY-ZSH ===

# Path to oh-my-zsh
ZSH="$HOME/.dotfiles/oh-my-zsh/"
ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh-custom/"

# Theme for OMZ
ZSH_THEME='dhg'

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git npm archlinux systemd virtualenv sudo nvmauto)
_check virtualenvwrapper.sh && plugins+=(virtualenvwrapper)



# ================ #
# === SOURCING === #

# Arch Linux command-not-found
[ -s '/etc/profile.d/cnf.sh' ] && source '/etc/profile.d/cnf.sh'

# Travis
[ -s "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

# Node Version Manager
[ -s "$HOME/.nvm/nvm.sh" ] && source "$HOME/.nvm/nvm.sh"


# OhMyZsh!!
source "$ZSH/oh-my-zsh.sh"


# =============== #
# === ALIASES === #

# Alias for hub
_check hub && alias git=hub
_check subl3 && alias subl=subl3

# Alias for reset
alias reset='env reset; source ~/.zshrc'

# Fix GREP_OPTIONS messages
alias grep="grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Fix problems with node-gyp and python3
alias npm='PYTHON=python2 npm'

alias poweroff='sudo poweroff'
alias reboot='sudo reboot'


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
export EDITOR=nano




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
}

# Apt-Get package manager
_check apt-get && {
    alias pm='sudo apt-get'
    alias pmnc='pm -y --no-install-recommends'
    alias pmupd='pmnc update && pmnc upgrade'

    alias pmin='pmnc install'
    alias pmrm='pmnc remove'
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
