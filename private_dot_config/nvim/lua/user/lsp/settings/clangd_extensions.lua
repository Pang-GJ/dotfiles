local status_ok, clangd = pcall(require, "clangd_extensions")
if not status_ok then
  vim.notify("clangd_extensions not found!")
  return
end

local status_ok2, lspconfig = pcall(require, "lspconfig")
if not status_ok2 then
  return
end

-- For clangd : (switch source header )
local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = lspconfig.util.validate_bufnr(bufnr)
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  vim.lsp.buf_request(bufnr, 'textDocument/switchSourceHeader', params, function(err, _, result)
    if err then error(tostring(err)) end
    if not result then print("Corresponding file can’t be determined") return end
    vim.api.nvim_command(splitcmd .. ' ' .. vim.uri_to_fname(result))
  end)
end

--[[]]
--[[ lspconfig.clangd.setup { ]]
--[[   -----snip------ ]]
--[[   commands = { ]]
--[[     ClangdSwitchSourceHeader = { ]]
--[[       function() switch_source_header_splitcmd(0, "edit") end; ]]
--[[       description = "Open source/header in a new vsplit"; ]]
--[[     }, ]]
--[[     ClangdSwitchSourceHeaderVSplit = { ]]
--[[       function() switch_source_header_splitcmd(0, "vsplit") end; ]]
--[[       description = "Open source/header in a new vsplit"; ]]
--[[     }, ]]
--[[     ClangdSwitchSourceHeaderSplit = { ]]
--[[       function() switch_source_header_splitcmd(0, "split") end; ]]
--[[       description = "Open source/header in a new split"; ]]
--[[     } ]]
--[[   } ]]
--[[ } ]]
--[[]]
clangd.setup {
  server = {
    -- options to pass to nvim-lspconfig
    -- i.e. the arguments to require("lspconfig").clangd.setup({})
    --[[ lspconfig.clangd.switch_source_header_splitcmd = switch_source_header_splitcmd, ]]
    lspconfig.clangd.setup({
      switch_source_header_splitcmd = switch_source_header_splitcmd,
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
      },
      cmd = {
        "clangd", -- NOTE: 只支持clangd 13.0.0 及其以下版本，新版本会有问题
        "--background-index", -- 后台建立索引，并持久化到disk
        "--clang-tidy", -- 开启clang-tidy
        -- 指定clang-tidy的检查参数， 摘抄自cmu15445. 全部参数可参考 https://clang.llvm.org/extra/clang-tidy/checks
        --[[ "--clang-tidy-checks=bugprone-*, clang-analyzer-*, google-*, modernize-*, performance-*, portability-*, readability-*, -bugprone-too-small-loop-variable, -clang-analyzer-cplusplus.NewDelete, -clang-analyzer-cplusplus.NewDeleteLeaks, -modernize-use-nodiscard, -modernize-avoid-c-arrays, -readability-magic-numbers, -bugprone-branch-clone, -bugprone-signed-char-misuse, -bugprone-unhandled-self-assignment, -clang-diagnostic-implicit-int-float-conversion, -modernize-use-auto, -modernize-use-trailing-return-type, -readability-convert-member-functions-to-static, -readability-make-member-function-const, -readability-qualified-auto, -readability-redundant-access-specifiers,", ]]
        "--completion-style=detailed",
        "--cross-file-rename=true",
        "--header-insertion=iwyu",
        "--pch-storage=memory",
        -- 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符
        "--function-arg-placeholders=true",
        "--log=verbose",
        "--ranking-model=decision_forest",
        -- 输入建议中，已包含头文件的项与还未包含头文件的项会以圆点加以区分
        "--header-insertion-decorators",
        "-j=12",
        "--pretty",
      }


    })
  },
  extensions = {
    -- defaults:
    -- Automatically set inlay hints (type hints)
    autoSetHints = true,
    -- These apply to the default ClangdSetInlayHints command
    inlay_hints = {
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- Event which triggers a refersh of the inlay hints.
      -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
      -- not that this may cause  higher CPU usage.
      -- This option is only respected when only_current_line and
      -- autoSetHints both are true.
      only_current_line_autocmd = "CursorHold",
      -- whether to show parameter hints with the inlay hints or not
      show_parameter_hints = true,
      -- prefix for parameter hints
      parameter_hints_prefix = "<- ",
      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = "=> ",
      -- whether to align to the length of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = "Comment",
      -- The highlight group priority for extmark
      priority = 100,
    },
    ast = {
      role_icons = {
        type = "",
        declaration = "",
        expression = "",
        specifier = "",
        statement = "",
        ["template argument"] = "",
      },

      kind_icons = {
        Compound = "",
        Recovery = "",
        TranslationUnit = "",
        PackExpansion = "",
        TemplateTypeParm = "",
        TemplateTemplateParm = "",
        TemplateParamObject = "",
      },

      highlights = {
        detail = "Comment",
      },
      memory_usage = {
        border = "none",
      },
      symbol_info = {
        border = "none",
      },
    },
  },
}
