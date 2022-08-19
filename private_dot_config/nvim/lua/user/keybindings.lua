-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }
local term_opt = {silent = true}

-- 定义按键绑定格式
-- map('模式', '按键', '映射为XX', opt)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


keymap("n", "<C-u>", "15k", opt)
keymap("n", "<C-d>", "15j", opt)

-- visual mode 代码缩进
keymap('v', '<', '<gv', opt)
keymap('v', '>', '>gv', opt)

-- 分屏相关
keymap('n', "sv", ":vsp<CR>", opt) -- 垂直分屏
keymap("n", "sh", ":sp<CR>", opt) -- 水平分屏
keymap("n", "sc", "<C-w>c", opt) -- 关闭当前分屏
keymap("n", "so", "<C-w>o", opt) -- 关闭其他分屏
-- alt+hjkl在窗口之间跳转
keymap("n", "<A-h>", "<C-w>h", opt)
keymap("n", "<A-j>", "<C-w>j", opt)
keymap("n", "<A-k>", "<C-w>k", opt)
keymap("n", "<A-l>", "<C-w>l", opt)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opt)
keymap("n", "<A-Down>", ":resize +2<CR>", opt)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opt)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opt)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opt)
keymap("n", "<S-h>", ":bprevious<CR>", opt)

-- Insert --
-- Press jj fast to ESC
keymap("i", "jj", "<ESC>", opt)
-- keymap("v", "jk", "<ESC>", opt)

-- Terminal --
-- Better terminal navigation
-- 已经在toggleterm.lua中定义
--[[
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opt)
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opt)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opt)
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", term_opt)
--]]

-- 插件相关的绑定： 

-- Telescope:
--keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opt)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
--keymap("n", "<leader>F", "<cmd>Telescope live_grep<cr>", opt)

-- Nvimtree
--keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opt)

-- LSP Format
--keymap("n", "<leader>lf", ":Format<cr>", opt)

-- gtags
-- find functions calling this function
-- keymap("n", "<leader>U", ":lua require('user.utils').GtagsRefernce()<cr>", opt)
-- find definition
-- keymap("n", "<leader>T", ":lua require('user.utils').GtagsText()<cr>", opt)
--

-- renamer keymap
vim.api.nvim_set_keymap('i', '<F2>', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>rn', '<cmd>lua require("renamer").rename()<cr>', { noremap = true, silent = true })

-- debug
-- debug
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint(); require'user.dap.dap-util'.store_breakpoints(true)<cr>", opt)
keymap("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", opt)
-- keymap("n", "<leader>dr", "lua require'dap'.repl.open()<cr>", opts)
keymap("n", "<F9>", "<cmd>lua require'dap'.run_last()<cr>", opt)
keymap('n', '<F10>', '<cmd>lua require"user.dap.dap-util".reload_continue()<CR>', opt)
keymap("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>", opt)
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opt)
keymap("n", "<F6>", "<cmd>lua require'dap'.step_over()<cr>", opt)
keymap("n", "<F7>", "<cmd>lua require'dap'.step_into()<cr>", opt)
keymap("n", "<F8>", "<cmd>lua require'dap'.step_out()<cr>", opt)
keymap("n", "K", "<cmd>lua require'dapui'.eval()<cr>", opt)
