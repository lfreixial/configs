# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# No theme — starship (initialized at the bottom of this file) owns the
# prompt and overrides whatever OMZ sets here, so computing an OMZ theme
# would just be wasted work on every startup.
ZSH_THEME=""

plugins=(
    git
    rbenv
    ruby
    aws
    buf
    # z omitted — zoxide (below) already does frecency-based cd and is
    # aliased over the cd builtin, so both would be redundant.
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
  file=${realpath:-$word}
  lower=$(printf "%s" "$file" | tr "[:upper:]" "[:lower:]")

  if [ -d "$file" ]; then
    if command -v eza >/dev/null 2>&1; then
      eza --color=always --icons=always --group-directories-first "$file"
    else
      ls --color "$file"
    fi
  else
    mime=$(file --brief --mime-type "$file" 2>/dev/null)

    case "$mime:$lower" in
      image/*:*)
        if command -v chafa >/dev/null 2>&1; then
          if [ -n "$KITTY_WINDOW_ID" ] && command -v kitten >/dev/null 2>&1; then
                if [ -n "$TMUX" ]; then
                  kitten icat --clear --transfer-mode=stream --stdin=no --passthrough=tmux --place="${FZF_PREVIEW_COLUMNS:-80}x${FZF_PREVIEW_LINES:-40}@0x0" --scale-up --align=left --loop=0 "$file"
                else
                  kitten icat --clear --transfer-mode=stream --stdin=no --passthrough=none --place="${FZF_PREVIEW_COLUMNS:-80}x${FZF_PREVIEW_LINES:-40}@0x0" --scale-up --align=left --loop=0 "$file"
                fi
              else
                chafa --format=symbols --symbols=braille --colors=256 --fg-only --animate=off --scale=max --size="${FZF_PREVIEW_COLUMNS:-80}x${FZF_PREVIEW_LINES:-40}" "$file"
              fi
        else
          printf "Image preview requires chafa: %s\n" "$file"
        fi
        ;;
      text/*:*|application/json:*|application/xml:*|application/javascript:*|application/x-shellscript:*|application/x-yaml:*|*:.env|*:*.md|*:*.toml|*:*.yaml|*:*.yml)
        if command -v bat >/dev/null 2>&1; then
          bat --style=numbers --color=always "$file"
        elif command -v batcat >/dev/null 2>&1; then
          batcat --style=numbers --color=always "$file"
        elif [ -f "$file" ]; then
          sed -n "1,200p" "$file"
        fi
        ;;
      *)
        file --brief "$file" 2>/dev/null || printf "Binary file: %s\n" "$file"
        ;;
    esac
  fi
'
 
# Aliases
if [ -f ~/.zsh_alias ]; then
    source ~/.zsh_alias
fi

# Load completions. compinit's security audit (compaudit) is the single
# biggest cost in shell startup (~1.5s) if it runs every time, so only
# do a full audit once a day; otherwise trust the cached dump (-C skips
# the audit entirely). Then byte-compile the dump in the background so
# the *next* startup loads it even faster.
setopt extendedglob
autoload -Uz compinit
_zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -n "$_zcompdump"(#qN.mh-24) ]]; then
    # Dump exists and is less than a day old — trust it, skip the audit.
    compinit -C -d "$_zcompdump"
else
    # Missing or stale — regenerate with the full security audit.
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
    if [ -f ~/.zsh_debian ]; then
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
