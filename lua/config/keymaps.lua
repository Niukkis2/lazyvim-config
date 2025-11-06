-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Run current JavaScript file with Node.js
vim.keymap.set("n", "<leader>js", function()
  local file_dir = vim.fn.expand("%:p:h")
  local cwd = vim.fn.getcwd()
  if file_dir ~= cwd then
    vim.cmd("cd " .. file_dir)
  end
  vim.cmd("!node %")
end, { desc = "Run current file with Node.js" })
