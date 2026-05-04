return {
  -- Fuzzy finder plugin
  "ibhagwan/fzf-lua",
  -- optional, since lazy.nvim loads dependencies automatically
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- The setup function is optional, and can be omitted to use the default settings
    require("fzf-lua").setup({})
  end,
}
