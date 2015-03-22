local SESSION_TYPE=''
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  SESSION_TYPE=remote
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE=remote;;
  esac
fi

# Colors
local _c_reset="$reset_color"
local _c_separator="$fg_bold[black]"
local _c_user="$fg_bold[green]"
local _c_user_root="$fg_bold[cyan]"
local _c_host="$fg_bold[yellow]"
local _c_path="$fg_bold[blue]"
local _c_remote="$fg[cyan]"
local _c_git_branch="$fg_bold[magenta]"
local _c_git_dirty="$fg_bold[white]"
local _c_prompt="$fg_bold[white]"
local _c_venv="$fg_bold[cyan]"
#local _c_clock="$fg_bold[white]"

local _o_hbar=$(printf "\e(0\x71\e(B")

function venv_prompt_info () {
    if [[ ! -z $VIRTUAL_ENV ]]; then
        printf "$(basename "$VIRTUAL_ENV")$_p_separator"
    fi
}

function hor_line() {
    #printf '%s' "%{$_c_separator%}"
    #printf '%*s\n' "${COLUMNS:-$(tput cols)} - 1" '_' | sed "s/ /$_o_hbar/g" | tr _ ' '
    #printf '\r%s' "%{$_c_reset%}"
}

# Prompt separator
local _p_separator='  '

# User prompt
local _p_user="%n%{$_c_separator%}$_p_separator"
if [ $(id -u) -eq 0 ]; then
    local _p_user="%{$_c_user_root%}$_p_user"
else
    local _p_user="%{$_c_user%}$_p_user"
fi

# Host prompt
local _p_host=
if [ "$SESSION_TYPE" = remote ]; then
    _p_host="%{$_c_host%}%m%{$_c_separator%}$_p_separator"
fi

# Path prompt
local _p_path="%{$_c_path%}%~%{$_c_separator%}$_p_separator"

local _p_status="%(?::%{$fg_bold[red]%}[%?]$_p_separator%s)"
local _p_dollar="$(if [ "$UID" -eq "0" ]; then echo '#'; else echo '$'; fi)"

#local _p_clock="%{$_c_clock%}%T"

PROMPT="\$(hor_line)$_p_status$_p_user$_p_host$_p_path\$(git_prompt_info)%{$_c_venv%}\$(venv_prompt_info)
%{$_c_prompt%}$_p_dollar %{$_c_reset%}"

RPROMPT="%{$(tput cuu 1)%}$_p_separator%{$(tput cud 1)$_c_reset%}"

# Git plugin configuration
ZSH_THEME_GIT_PROMPT_PREFIX="%{$_c_git_branch%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$_c_reset%}$_p_separator"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$_c_git_dirty%}*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

export VIRTUAL_ENV_DISABLE_PROMPT=

unset hor_line
unset venv_prompt_info
