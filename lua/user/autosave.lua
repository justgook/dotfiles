vim.opt.autowrite = true
local augroup = vim.api.nvim_create_augroup('autosave_cmd', {clear = true})
vim.api.nvim_create_autocmd("FocusLost", {
    pattern = "*",
    group = augroup,
    command ="wa"
})
