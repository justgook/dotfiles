local nnoremap = require("user.keymap").nnoremap
local inoremap = require("user.keymap").inoremap


nnoremap("<leader>pv", "<cmd>Ex<CR>")

-- Disable arrows
for _, key in ipairs({'<Up>', '<Down>', '<Left>', '<Right>'}) do
    nnoremap(key, '<nop>')
    inoremap(key, '<nop>')
end
