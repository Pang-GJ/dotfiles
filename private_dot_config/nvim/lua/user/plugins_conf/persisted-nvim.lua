local status_ok, persisted = pcall(require, "persisted")
if not status_ok then
  return
end

persisted.setup({
  save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
  command = "VimLeavePre", -- the autocommand for which the session is saved
  use_git_branch = true, -- create session files based on the branch of the git enabled repository
  autosave = false, -- automatically save session files when exiting Neovim
  autoload = false, -- automatically load the session for the cwd on Neovim startup
  allowed_dirs = {
    "~/CodeField",
  }, -- table of dirs that the plugin will auto-save and auto-load from
  ignored_dirs = {
    "~/.config",
    "~/.local/nvim"
  }, -- table of dirs that are ignored when auto-saving and auto-loading
  before_save = nil, -- function to run before the session is saved to disk
  after_save = nil, -- function to run after the session is saved to disk
  after_source = function()
    print("Session was saved!")
  end, -- function to run after the session is sourced
  telescope = { -- options for the telescope extension
    before_source = nil, -- function to run before the session is sourced via telescope
    after_source = function(session)
      print("Loaded session " .. session.name)
    end, -- function to run after the session is sourced via telescope
  },
})
