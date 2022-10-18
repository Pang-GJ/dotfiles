-- local colorscheme = "tokyonight"
local colorscheme = "gruvbox"
-- local colorscheme = "molokai"
-- local colorscheme = "monokai"
-- local colorscheme = "darkplus"
-- local colorscheme = "catppuccin"

require ("user.themes.monokai")

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
