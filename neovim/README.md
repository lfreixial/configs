# Neovim

[LazyVim](https://lazyvim.github.io/)-based Neovim config with Dracula theme, fzf, lazygit, and tmux integration.

## Plugins

| Plugin | Purpose |
|--------|---------|
| [Mofiqul/dracula.nvim](https://github.com/Mofiqul/dracula.nvim) | Dracula colour scheme |
| [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder |
| [f-person/git-blame.nvim](https://github.com/f-person/git-blame.nvim) | Inline git blame virtual text |
| [kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) | Lazygit inside Neovim |
| [LintaoAmons/scratch.nvim](https://github.com/LintaoAmons/scratch.nvim) | Temporary scratch buffers |
| [akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) | Floating/split terminal toggle |
| [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator) | Seamless pane navigation between Neovim and tmux |

## Keymaps

### Navigation

| Key | Action |
|-----|--------|
| `Ctrl+H/J/K/L` | Move between Neovim splits and tmux panes |

### Buffers

| Key | Action |
|-----|--------|
| `q` | Close current buffer |

### Terminal

| Key | Action |
|-----|--------|
| `Ctrl+\` | Toggle floating terminal |

### Git

| Key | Action |
|-----|--------|
| `<leader>gg` | Open LazyGit |

### Scratch buffers

| Key | Action |
|-----|--------|
| `Alt+Ctrl+N` | New named scratch buffer |
| `Alt+Ctrl+O` | Open existing scratch buffer |
| `<leader>r` | Run current buffer in a floating terminal (Python, Lua, Shell, Go) |

## Git blame

Inline blame is always on, showing:

```
<summary> • <date> • <author> • <sha>
```

## Structure

```
neovim/
├── init.lua                  # Entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua      # Custom autocommands
│   │   ├── keymaps.lua       # Custom keymaps
│   │   ├── lazy.lua          # Lazy.nvim bootstrap
│   │   └── options.lua       # Editor options
│   └── plugins/              # One file per plugin spec
└── lazyvim.json              # LazyVim extras
```
