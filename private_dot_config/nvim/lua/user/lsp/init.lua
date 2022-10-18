local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end


require("user.lsp.settings.clangd_extensions") -- 试试好不好用
require("user.lsp.lsp-installer")
require("user.lsp.lsp-signature")
require("user.lsp.handlers").setup()
-- require("user.lsp.null-ls")
-- 语言的LSP server自带format

