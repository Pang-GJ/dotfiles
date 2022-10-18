-- This config here is for nvui

if vim.g.nvui then
  -- Set gui font
    vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h12]]
    vim.cmd [[NvuiCmdFontFamily FiraCode Nerd Font]]
    vim.cmd [[NvuiCmdFontSize 12.0]]
    vim.cmd [[NvuiScrollAnimationDuration 0.2]]
end

if vim.g.vscode then
  -- VSCode extension 
else
-- TODO: 目前 impatient 貌似和 nvim-surround 有冲突
require "user.plugins_conf.impatient" -- 改善nvovim启动时间，需要放在init.lua的第一行

require "user.options"
require "user.keybindings"
require "user.colorscheme"
require "user.lsp"

require "user.dap"

require "user.plugins"
require "user.plugins_conf"
end
