return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Optional settings, you can customize these
        size = 20,
        open_mapping = [[<c-\>]],
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        persist_size = true,
        direction = "float", -- or "horizontal" or "vertical"
        close_on_exit = true,
        shell = vim.o.shell,
      })
    end,
  },
}
