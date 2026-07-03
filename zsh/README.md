# Zsh

Zsh config built on Oh My Zsh and Zinit, with Starship prompt, fzf-tab completion, and OS-specific overrides for macOS and Debian/Ubuntu.

## Frameworks & plugins

| Tool | Purpose |
|------|---------|
| [Oh My Zsh](https://ohmyz.sh/) | Plugin/theme framework |
| [Zinit](https://github.com/zdharma-continuum/zinit) | Fast plugin loader |
| [Starship](https://starship.rs/) | Cross-shell prompt |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [chafa](https://hpjansson.org/chafa/) | Terminal image previews in `fzf` |
| [gh](https://cli.github.com/) | GitHub CLI — powers the `gh*` aliases and PR-picker functions |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smarter `cd` with frecency |
| [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) | Fish-style command suggestions |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Live syntax highlighting |
| [fzf-tab](https://github.com/Aloxaf/fzf-tab) | fzf-powered tab completion |

### Oh My Zsh plugins

`git` · `rbenv` · `ruby` · `aws` · `buf` · `z`

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
| `cat` | `bat` / `batcat` (OS-dependent) |

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
