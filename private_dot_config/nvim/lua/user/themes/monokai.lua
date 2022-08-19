local status_ok, monokai = pcall(require, "monokai")
if not status_ok then
  vim.notify("monokai not found")
  return
end

monokai.setup({
  palette = monokai.soda
}
)
