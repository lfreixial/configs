# Zsh

Zsh config built on Oh My Zsh and Zinit, with Starship prompt, fzf-tab completion, and OS-specific overrides for macOS, Debian/Ubuntu, and Arch Linux.

## Frameworks & plugins

| Tool | Purpose |
|------|---------|
| [Oh My Zsh](https://ohmyz.sh/) | Plugin/theme framework |
| [Zinit](https://github.com/zdharma-continuum/zinit) | Fast plugin loader |
| [Starship](https://starship.rs/) | Cross-shell prompt |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [chafa](https://hpjansson.org/chafa/) | Terminal image previews in `fzf` — auto-negotiates kitty/iterm/sixel graphics protocols, so real images render in Ghostty, Kitty, WezTerm, iTerm2, etc., falling back to ANSI art elsewhere |
| [gh](https://cli.github.com/) | GitHub CLI — powers the `gh*` aliases and PR-picker functions |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` with frecency |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style command suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Live syntax highlighting |
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | fzf-powered tab completion |
| [zsh-you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use) | Reminds you when you type something you already have an alias for |
| [direnv](https://direnv.net/) (`OMZP::direnv`) | Auto-loads/unloads a directory's `.envrc` |

### Oh My Zsh plugins

`git` · `rbenv` · `ruby` · `aws` · `buf`

## File structure

| File | Contents |
|------|---------|
| `.zshrc` | Entry point — sources all other files |
| `.zsh_alias` | Aliases |
| `.zsh_functions` | Shell functions |
| `.zsh_exports` | Environment variable exports |
| `.zsh_init` | Zinit plugin declarations |
| `.zsh_keybinds` | Key bindings |
| `.zsh_mac` | macOS-specific config |
| `.zsh_debian` | Debian/Ubuntu-specific config |
| `.zsh_arch` | Arch Linux-specific config |
| `~/.zsh_secrets` | Secrets (not tracked — create locally) |

## Aliases

### Editor

| Alias | Command |
|-------|---------|
| `v`, `vim` | `nvim` |
| `zs` | Open `.zshrc` in Neovim |
| `sz` | Source `.zshrc` |

### Navigation & files

| Alias | Command |
|-------|---------|
| `c` | `clear` |
| `ls` | `eza` with icons, git status, and colours |
| `f` | fzf file picker with `bat` text previews and `chafa` image previews → open in Neovim |
| `cat` | `bat` / `batcat` (OS-dependent — Debian/Ubuntu package `bat` as `batcat`; Arch and macOS ship the `bat` binary directly) |

### Git

| Alias | Command |
|-------|---------|
| `lg` | `lazygit` |
| `gcm` | `git checkout origin/main` |
| `gce` | Fetch, pull, push an empty commit tagged `run-ci` |

### GitHub CLI

| Alias | Command |
|-------|---------|
| `ghb` | `gh browse` |
| `ghs` | `gh status` |
| `ghl` | `gh pr list` |
| `ghw` | `gh pr view --web` |
| `prs` | fzf PR picker → checkout |
| `pr` | fzf PR picker → open in browser |

### Docker

| Alias | Command |
|-------|---------|
| `dcu` | `docker compose up -d` |
| `dcub` | `docker compose up --build -d` |
| `dcd` | `docker compose down` |
| `dps` | `docker ps` |
| `dk` | Kill container via fzf picker |

### Go

| Alias | Command |
|-------|---------|
| `gt` | `go test ./...` |

### tmux

| Alias | Command |
|-------|---------|
| `ta` | Attach to session via fzf picker |
| `tn` | Create new named session |
| `tk` | Kill session via fzf picker |
| `st` | Reload tmux config |

### Misc

| Alias | Command |
|-------|---------|
| `e` | `exit` |

## Functions

| Function | Description |
|----------|-------------|
| `load-nvmrc` | Auto-switches Node version when entering a directory with an `.nvmrc` |
| `fzf-cd-widget` | fzf directory picker — jump to any subdirectory |
| `select_and_open_pr` | fzf open PR list → checkout branch (`prs`) |
| `select_and_open_pr_web_only` | fzf open PR list → open in browser (`pr`) |
| `tmux-attach` | fzf session list → attach (`ta`) |
| `tmux-new` | Prompt for a name → create new tmux session (`tn`) |
| `tmux-kill` | fzf session list → kill session (`tk`) |
| `docker_kill_fzf` | fzf running container list → kill (`dk`) |
| `tmux_start_music` | Launch `spotify_player` in a dedicated tmux session |
| `zsh_fzf_preview` | Renders an fzf preview pane: `eza` for dirs, `bat` for text, `chafa` for images, `file` otherwise. Used by the fzf-tab completion preview and `f` |
| `zsh_image_preview` | Renders an image via `chafa`, which auto-negotiates the kitty/iterm/sixel graphics protocol for the connected terminal (Ghostty, Kitty, WezTerm, iTerm2, ...), falling back to ANSI art |

`zsh_fzf_preview` and `zsh_image_preview` are also written out as small standalone scripts under `$ZSH_FZF_PREVIEW_CACHE` on every shell startup, since fzf runs `--preview` commands in a fresh non-interactive shell that wouldn't otherwise see them. The `f` picker and the fzf-tab preview call the cached scripts (`$ZSH_FZF_PREVIEW`, `$ZSH_IMAGE_PREVIEW`) rather than the functions directly.

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+P` | History search backward |
| `Ctrl+N` | History search forward |
| `Alt+W` | Kill region |
| `Alt+F` | fzf directory picker (`fzf-cd-widget`) |

## History

- Size: 5000 entries
- Duplicates are erased, ignored on search, and not saved
- History is shared across all sessions
- Commands prefixed with a space are not saved
