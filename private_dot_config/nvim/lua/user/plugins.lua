local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter

  use "numToStr/Comment.nvim" -- Easily comment stuff

  use "ahmedkhalf/project.nvim" -- 项目插件
  use "windwp/nvim-spectre" --  Search and replace panel for Neovim.

  use "lewis6991/impatient.nvim" -- 改善neovim启动时间

  -- 上一次打开的文件位置
  use "ethanholz/nvim-lastplace"

  -- session
  --[[ use { ]]
  --[[   "folke/persistence.nvim", ]]
  --[[   event = "BufReadPre", -- this will only start session saving when an actual file was opened ]]
  --[[   module = "persistence", ]]
  --[[   config = function() ]]
  --[[     require("persistence").setup { ]]
  --[[       dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"), ]]
  --[[       options = { "buffers", "curdir", "tabpages", "winsize" }, ]]
  --[[     } ]]
  --[[   end, ]]
  --[[ } ]]
  use({
    "olimorris/persisted.nvim",
    module = "persisted", -- For lazy loading
    config = function()
      require("persisted").setup()
      require("telescope").load_extension("persisted") -- To load the telescope extension
    end,
  })

  -- Colorschemes
  --[[ use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out ]]
  use 'folke/tokyonight.nvim' -- 经典主题
  --[[ use "lunarvim/darkplus.nvim" ]]
  use "tomasr/molokai" -- molokai
  use "ellisonleao/gruvbox.nvim" --gruvbox
  use 'tanvirtin/monokai.nvim' -- monokai
  use "navarasu/onedark.nvim"  -- onedark

  -- completion
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua" -- 这个在配置VIM的时候可以提供vim相关的补全

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- auto save
  use "Pocco81/AutoSave.nvim"

  -- nvim-surround
  use "tpope/vim-surround"

  -- motion
  use "phaazon/hop.nvim" -- something like esay-motion but more powerful

  -- Nvim-Tree
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'

  -- Markdonw Preview
  use "davidgranstrom/nvim-markdown-preview"

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  --[[ use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters ]]
  use "folke/trouble.nvim" --  A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.

  use {
    'Kohirus/cppassist.nvim',
    opt = true,
    ft = { "h", "cpp", "hpp", "c", "cc", "cxx" },
    config = function()
      require("cppassist").setup()
    end,
  }

  use "p00f/clangd_extensions.nvim" -- 不知道好不好用，尝试一下
  use "ray-x/lsp_signature.nvim"
  use "kosayoda/nvim-lightbulb" -- code action 会有💡提示
  use "antoinemadec/FixCursorHold.nvim" -- nvim-lightbulb 的依赖
  use "folke/lsp-colors.nvim" -- 提示（错误提示、灯泡提示）
  use {
  'weilbith/nvim-code-action-menu',
  cmd = 'CodeActionMenu',
  }

  -- Rename
  -- use {
  --   'filipdutescu/renamer.nvim',
  --   branch = 'master',
  --   requires = { { 'nvim-lua/plenary.nvim' } }
  -- }
  -- Better quickfix window
  use { 'kevinhwang91/nvim-bqf' }
  --optional
  use { 'junegunn/fzf', run = function()
    vim.fn['fzf#install']()
  end
  }

  -- tabout
  use "abecodes/tabout.nvim"

  -- 运行代码段
  use { "michaelb/sniprun", run = "zsh ./install.sh" }

  -- waketime
  use "wakatime/vim-wakatime"

  --CMake
  --[[ use "ravenxrz/neovim-cmake" ]]
  use "Civitasv/cmake-tools.nvim"

  --gtags
  --use "jsfaint/gen_tags.vim"

  -- Debugger
  use {
    "sakhnik/nvim-gdb",
    run = "./install.sh"
  }
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  -- Outline
  use "simrat39/symbols-outline.nvim" -- tree-like symbol outline

  -- Telescope
  use "nvim-telescope/telescope.nvim" --
  use "nvim-telescope/telescope-ui-select.nvim"
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use {
    requires = { "nvim-treesitter/nvim-treesitter" },
    "Badhi/nvim-treesitter-cpp-tools", -- 提供函数定义代码生成功能
  }

  -- Todo comments
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- JS 注释

  use "romgrk/nvim-treesitter-context" -- 当函数代码太长，在屏幕顶部显示函数名称

  -- Bufferline
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"

  -- 缩进提示
  use "lukas-reineke/indent-blankline.nvim"

  -- Git
  use "lewis6991/gitsigns.nvim"
  -- gitui
  -- use "is0n/fm-nvim" -- bad, it's slow
  use {
    "aspeddro/gitui.nvim",
    config = function()
      require("gitui").setup()
    end,
  }


  -- 底部状态栏
  use 'nvim-lualine/lualine.nvim'

  -- dashboard
  use 'goolord/alpha-nvim'

  -- whichkey
  use "folke/which-key.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"

  -- beautiful notify
  use "rcarriga/nvim-notify"

  -- 翻译
  -- use "voldikss/vim-translator"

  -- smooth scrolling
  use 'karb94/neoscroll.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
