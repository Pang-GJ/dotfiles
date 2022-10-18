local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local normal_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local normal_mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha Dashboard" },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["f"] = {
    "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Find files",
  },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },

  --[[
  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },
  --]]

  --[[
  C = {
    name = "CMake",
    g = {"<cmd>CMake configure<CR>", "Configure"},
    t = {"<cmd>CMake select_target<CR>", "SelectTarget"},
    T = {"<cmd>CMake select_build_type<CR>", "SelectBuildType"},
    b = {"<cmd>CMake build<CR>", "BuildTarget"},
    a = {"<cmd>CMake build_all<CR>", "BuildAll"},
    r = {"<cmd>CMake build_and_run<CR>", "Run"},
    d = {"<cmd>CMake build_and_debug<CR>", "DebugTarget"},
    c = {"<cmd>CMake cancel<CR>", "Cancel"},
    s = {"<cmd>CMake set_target_args<CR>", "SetArg"},
  },
  --]]

  d = {
    name = "Debugger",
  },


  g = {
    name = "Git",
    G = { "<cmd>lua require('gitui').open()<CR>", "Gitui" },
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },

  R = {
    name = "Replace",
    f = { "<cmd>lua require('spectre').open_file_search()<CR>", "Replace File" },
    p = { "<cmd>lua require('spectre').open()<CR>", "Replace Project" },
    s = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Search" },
    -- -- 全项目替换
    -- vim.keybinds.gmap("n", "<leader>rp", "", vim.keybinds.opts)
    -- -- 只替换当前文件
    -- vim.keybinds.gmap("n", "<leader>rf", , vim.keybinds.opts)
    -- -- 全项目中搜索当前单词
    -- vim.keybinds.gmap("n", "<leader>rw", , vim.keybinds.opts)
  },


  l = {
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },

    i = { "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", "Call Tree" },
    --i = { "<cmd>LspInfo<cr>", "Info" },
    --I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      --"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", -- 貌似更改了API？
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },

    o = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Source Header" },

    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },

  H = {
    name = "Help",
    --b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },

  T = {
    name = "Trouble",
    t = { "<cmd>Trouble<cr>", "ToggleTrouble" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Document Diagnostics"},
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics"},
    q = { "<cmd>Trouble quickfix<cr>", "Quick Fix"},
    u = { "<cmd>Trouble lsp_references<cr>", "Usage"},
    g = { "<cmd>Gitsigns setloclist<cr>", "Open changed hunk" },
  },

  S = {
    name = "Session",
    t = { "<cmd>SessionToggle<cr>", "Session Toggle" },
    w = { "<cmd>SessionSave<cr>", "Session Save" },
    s = { "<cmd>Telescope persisted<cr>", "Search Session" },
    q = { "<cmd>SessionStop<cr>", "Session Stop" },
    c = { "<cmd>SessionLoad<cr>", "Load session for current dir" },
    l = { "<cmd>SessionLoadLast<cr>", "Load last session" },
    d = { "<cmd>SessionDelete<cr>", "Delete current session" },
    --c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    --l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    --Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  },

  ["O"] = { "<cmd>SymbolsOutline<cr>", "Outline" },

  --[[
  t = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  --]]
}


local visual_opts = {
  mode = "v", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  vnoremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local visual_mappings = {
  g = {
    -- For "Badhi/nvim-treesitter-cpp-tools"
    name = "Cpp Generate",
    d = { "<cmd>'<,'>TSCppDefineClassFunc<cr>", "Define Class Func"},
    v = { "<cmd>'<,'>TSCppMakeConcreteClass<cr>", "Concrete class impl virtual func"},
    ["3"] = { "<cmd>'<,'>TSCppRuleOf3<cr>", "Add func by Rule 3"},
    ["5"] = { "<cmd>'<,'>TSCppRuleOf5<cr>", "Add func by Rule 5"},
  },
}

which_key.setup(setup)
which_key.register(normal_mappings, normal_opts)
which_key.register(visual_mappings, visual_opts)
