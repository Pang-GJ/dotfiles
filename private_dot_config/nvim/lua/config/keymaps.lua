-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap

-- delete default keymaps
keymap.del("n", "<leader>L", {})

keymap.set("i", "jj", "<ESC>")

keymap.set("n", "<leader>h", "<cmd>:noh<cr>", { desc = "No highlight" })
