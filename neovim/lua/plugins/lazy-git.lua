-- ~/.config/nvim/lua/config/lazygit.lua
return {
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
  },
  config = function()
    vim.g.lazygit_config = {
      "--use-config-file=" .. os.getenv("HOME") .. "/.config/lazygit/config.yml",
    }
  end,
}
