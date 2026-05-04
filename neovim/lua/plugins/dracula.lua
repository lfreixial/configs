return {
  -- Install Dracula theme
  { "Mofiqul/dracula.nvim", lazy = false },

  -- Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dracula",
    },
  },
}
