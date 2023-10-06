local M = {}

local function bind(op, outer_opts)
  outer_opts = outer_opts or {noremap = true}
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force",
      outer_opts,
      opts or {}
    )
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local nmap = bind("n", {noremap = false})
local nnoremap = bind("n")
local vnoremap = bind("v")
local xnoremap = bind("x")
local inoremap = bind("i")

nnoremap('<Up>', '<nop>')
nnoremap('<Down>', '<nop>')
nnoremap('<Left>', '<nop>')
nnoremap('<Right>', '<nop>')
inoremap('<Up>', '<nop>')
inoremap('<Down>', '<nop>')
inoremap('<Left>', '<nop>')
inoremap('<Right>', '<nop>')
vnoremap('<Up>', '<nop>')
vnoremap('<Down>', '<nop>')
vnoremap('<Left>', '<nop>')
vnoremap('<Right>', '<nop>')

-- Move Lines
nnoremap("<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
nnoremap("<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
inoremap("<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
inoremap("<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vnoremap("<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vnoremap("<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- better indenting
vnoremap("<", "<gv")
vnoremap(">", ">gv")

--keywordprg
nnoremap("<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })
-- lazy
nnoremap( "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
nnoremap("<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

nnoremap ("<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
nnoremap ("<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })


M.nmap = nmap
M.nnoremap = nnoremap
M.vnoremap = vnoremap
M.xnoremap = xnoremap
M.inoremap = inoremap

return M

