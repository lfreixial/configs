# tmux

tmux config with Dracula theme, vi copy mode, and TPM plugin management.

## Plugins

| Plugin | Purpose |
|--------|---------|
| [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm) | Plugin manager |
| [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | Sane defaults |
| [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless pane navigation with Neovim |
| [tmux-plugins/tmux-yank](https://github.com/tmux-plugins/tmux-yank) | Copy to system clipboard |
| [tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | Save and restore sessions |
| [tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | Auto-save sessions and start tmux on boot |
| [dracula/tmux](https://github.com/dracula/tmux) | Dracula status bar theme |

## Keybindings

Prefix is `Ctrl+Space` (default is `Ctrl+B`).

### Panes

| Key | Action |
|-----|--------|
| `Prefix + H/J/K/L` | Move between panes (vim-style) |
| `Alt + Arrow` | Move between panes (no prefix) |
| `Prefix + "` | Split horizontally (same directory) |
| `Prefix + %` | Split vertically (same directory) |

### Windows

| Key | Action |
|-----|--------|
| `Shift + Left/Right` | Previous / next window |
| `Alt + H/L` | Previous / next window (vim-style) |

### Sessions

| Key | Action |
|-----|--------|
| `Prefix + N` | New session (popup prompt) |
| `Prefix + J` | Switch session via fzf picker |

### Copy mode

| Key | Action |
|-----|--------|
| `Prefix + [` | Enter copy mode |
| `V` | Start visual selection |
| `Ctrl+V` | Toggle rectangle selection |
| `Y` | Copy selection to clipboard |

### TPM

| Key | Action |
|-----|--------|
| `Prefix + I` | Install plugins |
| `Prefix + U` | Update plugins |
| `Prefix + Alt+U` | Remove unlisted plugins |

## Status bar

Position: top. Powered by the Dracula theme with these widgets (left to right):

`git` · `weather` · `battery` · `time` · `ssh-session`

- Weather uses `@dracula-fixed-location` — set your city during `make` setup or edit `~/.tmux.conf` directly
- Time shows two timezones, configured via `@dracula-time`
- Windows and panes are indexed from `1`
- Mouse support is enabled
