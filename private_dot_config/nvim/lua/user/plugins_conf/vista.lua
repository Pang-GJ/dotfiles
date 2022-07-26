vim.cmd(
    [[
" 缩进显示方式
" let g:vista_icon_indent = ["▸ ", ""]
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" 通过那种方式渲染大纲预览（ctags 或者 nvim_lsp）
let g:vista_default_executive = 'nvim_lsp'
" 启用图标支持"
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
]]
)