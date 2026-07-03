# configs

Personal dotfiles for Zsh, Neovim, and tmux — targeting macOS and Debian/Ubuntu Linux.

## What's included

| Directory | Contents |
|-----------|----------|
| `zsh/`    | `.zshrc`, aliases, exports, functions, OS-specific configs, keybindings |
| `tmux/`   | `.tmux.conf` with Dracula theme, vi copy mode, and TPM plugins |
| `neovim/` | [LazyVim](https://www.lazyvim.org/)-based Neovim config with fzf, toggleterm, dracula, and more |

## Requirements

- macOS or Debian/Ubuntu Linux
- `zsh` as the default shell
- `git`
- `make`

Everything else (Neovim, tmux, Oh My Zsh, Zinit, Starship, fzf, fd, ripgrep, eza, bat, zoxide, rbenv, lazygit, gh, jq, chafa, xclip, Nerd Fonts...) is installed automatically by the Makefile.

`spotify_player` (used by `tmux_start_music`) is a manual install — it needs interactive OAuth setup, so it's intentionally left out of the automated dependency install.

## Install

```sh
git clone <this-repo> ~/configs
cd ~/configs
make
```

This will:
1. Install all missing dependencies (OS-aware)
2. Copy zsh config files to `~`
3. Copy `.tmux.conf` to `~` and install TPM plugins
4. Copy the Neovim config to `~/.config/nvim`

Existing files are backed up with a `.bak` suffix before being overwritten.

## Updating (pulling live config back into this repo)

```sh
make update-zsh   # copies ~/.zsh_* back into zsh/
make update-tmux  # copies ~/.tmux.conf back into tmux/
make update-nvim  # copies ~/.config/nvim back into neovim/
```

## Secrets

Shell secrets (API keys, tokens, etc.) are kept in `~/.zsh_secrets`, which is sourced by `.zshrc` but **never committed** to this repo. Create it locally:

```sh
touch ~/.zsh_secrets
```

## Customisation notes

- **Tmux weather/location** — `make` will prompt you for a city name during setup; you can also edit `@dracula-fixed-location` directly in `~/.tmux.conf` afterwards
- **Tmux timezones** — `@dracula-time` accepts a comma-separated list of TZ identifiers (e.g. `"Europe/London,America/New_York"`)
- **Neovim plugins** — add Lua plugin specs under `neovim/lua/plugins/`
- **Zsh extras** — OS-specific config lives in `.zsh_mac` (macOS) and `.zsh_debian` (Linux)

## Key tools

- **Shell**: [Oh My Zsh](https://ohmyz.sh/) + [Zinit](https://github.com/zdharma-continuum/zinit) + [Starship](https://starship.rs/)
- **Fuzzy finding**: [fzf](https://github.com/junegunn/fzf) + [fzf-tab](https://github.com/Aloxaf/fzf-tab)
- **File search**: [fd](https://github.com/sharkdp/fd) + [ripgrep](https://github.com/BurntSushi/ripgrep)
- **Navigation**: [zoxide](https://github.com/ajeetdsouza/zoxide)
- **File listing**: [eza](https://github.com/eza-community/eza)
- **Paging/cat**: [bat](https://github.com/sharkdp/bat)
- **Terminal image previews**: [chafa](https://hpjansson.org/chafa/)
- **Git TUI**: [lazygit](https://github.com/jesseduffield/lazygit)
- **GitHub CLI**: [gh](https://cli.github.com/) — used by the `gh*` aliases and PR-picker functions
- **Clipboard (Linux)**: `xclip` — used by the `tmux-yank` plugin for system clipboard copy
- **Tmux theme**: [Dracula](https://draculatheme.com/tmux)
- **Neovim distro**: [LazyVim](https://www.lazyvim.org/)
