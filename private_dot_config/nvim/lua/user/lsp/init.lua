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

-- For clangd : (switch source header )
local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = lspconfig.util.validate_bufnr(bufnr)
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
      if err then error(tostring(err)) end
      if not result then print ("Corresponding file can’t be determined") return end
      vim.api.nvim_command(splitcmd..' '..vim.uri_to_fname(result))
  end)
end

lspconfig.clangd.switch_source_header_splitcmd = switch_source_header_splitcmd

lspconfig.clangd.setup {
 -----snip------
  commands = {
    ClangdSwitchSourceHeader = {
      function() switch_source_header_splitcmd(0, "edit") end;
      description = "Open source/header in a new vsplit";
    },
    ClangdSwitchSourceHeaderVSplit = {
      function() switch_source_header_splitcmd(0, "vsplit") end;
      description = "Open source/header in a new vsplit";
    },
    ClangdSwitchSourceHeaderSplit = {
      function() switch_source_header_splitcmd(0, "split") end;
      description = "Open source/header in a new split";
    }
  }
}
