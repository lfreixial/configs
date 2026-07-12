# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# starship (below) owns the prompt, so no OMZ theme needed
ZSH_THEME=""

plugins=(
    git
    rbenv
    ruby
    aws
    buf
)

source $ZSH/oh-my-zsh.sh

# Zinit configuration
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

if [ -f ~/.zsh_functions ]; then
    source ~/.zsh_functions
fi

# z init
if [ -f ~/.zsh_init ]; then
    source ~/.zsh_init
fi

# Keybindings
if [ -f ~/.zsh_keybinds ]; then
    source ~/.zsh_keybinds
fi

# History settings
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS


# Load fzf if available
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  "$ZSH_FZF_PREVIEW" "${realpath:-$word}"
'
 
# Aliases
if [ -f ~/.zsh_alias ]; then
    source ~/.zsh_alias
fi

# Load completions. Skip compinit's security audit unless the dump is
# missing/stale (>24h) — audit is the biggest single cost otherwise.
setopt extendedglob
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n "$_zcompdump"(#qN.mh-24) ]]; then
    compinit -C -d "$_zcompdump"
else
    compinit -d "$_zcompdump"
fi
{
    if [[ -s "$_zcompdump" && ( ! -s "$_zcompdump.zwc" || "$_zcompdump" -nt "$_zcompdump.zwc" ) ]]; then
        zcompile "$_zcompdump"
    fi
} &!
unset _zcompdump

# Place this after nvm initialization!
autoload -U add-zsh-hook
add-zsh-hook chpwd load-nvmrc
load-nvmrc
zle -N fzf-cd-widget

# exports
if [ -f ~/.zsh_exports ]; then
    source ~/.zsh_exports
fi

# Secrets
if [ -f ~/.zsh_secrets ]; then
    source ~/.zsh_secrets
fi

# OS-specific configurations
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if command -v pacman >/dev/null 2>&1; then
        if [ -f ~/.zsh_arch ]; then
            source ~/.zsh_arch
        fi
    elif [ -f ~/.zsh_debian ]; then
        source ~/.zsh_debian
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    if [ -f ~/.zsh_mac ]; then
        source ~/.zsh_mac
    fi
fi

# Initialize other tools
eval "$(zoxide init --cmd cd zsh)"
eval "$(rbenv init -)"
eval "$(starship init zsh)"
