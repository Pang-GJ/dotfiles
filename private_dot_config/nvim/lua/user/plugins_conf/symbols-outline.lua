-- https://github.com/simrat39/symbols-outline.nvim

--[[
Commands
Command	Description
:SymbolsOutline	Toggle symbols outline
:SymbolsOutlineOpen	Open symbols outline
:SymbolsOutlineClose	Close symbols outline

Default keymaps
Key	Action
Escape	Close outline
Enter	Go to symbol location in code
o	Go to symbol location in code without losing focus
Ctrl+Space	Hover current symbol
K	Toggles the current symbol preview
r	Rename symbol
a	Code actions
?	Show help message
--]]

local ok, outline = pcall(require, "symbols-outline")
if not ok then
  return
end

local opts = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = 'right',
  relative_width = true,
  width = 25,
  auto_close = false,
  show_numbers = true,
  show_relative_numbers = false,
  show_symbol_details = true,
  preview_bg_highlight = 'Pmenu',
  keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = {"<Esc>", "q"},
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "gh",
      toggle_preview = "K",
      rename_symbol = "r",
      code_actions = "a",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
      File = {icon = "", hl = "TSURI"},
      Module = {icon = "", hl = "TSNamespace"},
      Namespace = {icon = "", hl = "TSNamespace"},
      Package = {icon = "", hl = "TSNamespace"},
      Class = {icon = "𝓒", hl = "TSType"},
      Method = {icon = "ƒ", hl = "TSMethod"},
      Property = {icon = "", hl = "TSMethod"},
      Field = {icon = "", hl = "TSField"},
      Constructor = {icon = "", hl = "TSConstructor"},
      Enum = {icon = "ℰ", hl = "TSType"},
      Interface = {icon = "ﰮ", hl = "TSType"},
      Function = {icon = "", hl = "TSFunction"},
      Variable = {icon = "", hl = "TSConstant"},
      Constant = {icon = "", hl = "TSConstant"},
      String = {icon = "𝓐", hl = "TSString"},
      Number = {icon = "#", hl = "TSNumber"},
      Boolean = {icon = "⊨", hl = "TSBoolean"},
      Array = {icon = "", hl = "TSConstant"},
      Object = {icon = "⦿", hl = "TSType"},
      Key = {icon = "🔐", hl = "TSType"},
      Null = {icon = "NULL", hl = "TSType"},
      EnumMember = {icon = "", hl = "TSField"},
      Struct = {icon = "𝓢", hl = "TSType"},
      Event = {icon = "🗲", hl = "TSType"},
      Operator = {icon = "+", hl = "TSOperator"},
      TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  }
}

outline.setup({opts})
