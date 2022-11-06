local nnoremap = require("user.keymap").nnoremap
local inoremap = require("user.keymap").inoremap


nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap('x', '"_x') -- not yank "x"

-- Increment/decrement
nnoremap('+', '<C-a>')
nnoremap('-', '<C-x>')
-- Select all
nnoremap('<C-a>', 'gg<S-v>G')

-- Disable arrows
for _, key in ipairs({'<Up>', '<Down>', '<Left>', '<Right>'}) do
    nnoremap(key, '<nop>')
    inoremap(key, '<nop>')
end
