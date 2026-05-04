-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<M-C-n>", "<cmd>ScratchWithName<cr>")
vim.keymap.set("n", "<M-C-o>", "<cmd>ScratchOpen<cr>")
vim.keymap.set("n", "q", "<cmd>bd<cr>", { desc = "Close current buffer" })

local Terminal = require("toggleterm.terminal").Terminal

vim.keymap.set("n", "<leader>r", function()
  local ft = vim.bo.filetype
  local tmpfile = "/tmp/scratch_run"

  if ft == "python" then
    tmpfile = tmpfile .. ".py"
    vim.cmd("write! " .. tmpfile)
    Terminal:new({
      cmd = "bash -c 'python3 " .. tmpfile .. "; exec $SHELL'",
      hidden = false,
      direction = "float",
    }):toggle()
  elseif ft == "lua" then
    tmpfile = tmpfile .. ".lua"
    vim.cmd("write! " .. tmpfile)
    Terminal:new({
      cmd = "bash -c 'lua " .. tmpfile .. "; exec $SHELL'",
      hidden = false,
      direction = "float",
    }):toggle()
  elseif ft == "sh" then
    tmpfile = tmpfile .. ".sh"
    vim.cmd("write! " .. tmpfile)
    Terminal:new({
      cmd = "bash -c 'bash " .. tmpfile .. "; exec $SHELL'",
      hidden = false,
      direction = "float",
    }):toggle()
  elseif ft == "go" then
    tmpfile = tmpfile .. ".go"
    vim.cmd("write! " .. tmpfile)
    Terminal:new({
      -- Run the Go file with `go run`
      cmd = "bash -c 'go run " .. tmpfile .. "; exec $SHELL'",
      hidden = false,
      direction = "float",
    }):toggle()
  else
    print("No run command configured for filetype: " .. ft)
  end
end, { desc = "Run scratch buffer in floating terminal" })
