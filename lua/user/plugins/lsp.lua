-- Enable the following language serversh vim.lsp.buf.formatting()
local servers = { 'clangd', 'tsserver', 'lua_ls', 'gopls' }

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
  float = { border = "rounded" },
})


local signs = require("user.config").icons.diagnostics
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


local nnoremap = require("user.config.keymap").nnoremap
local inoremap = require("user.config.keymap").inoremap


-- https://www.lazyvim.org/keymaps#lsp
local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
-- Diagnostic keymaps
nnoremap('<leader>ca', vim.lsp.buf.code_action, { desc = "Code Action" })
nnoremap('<leader>cr', vim.lsp.buf.rename, { desc = "Rename" })

nnoremap('<leader>cd', vim.diagnostic.open_float, { desc = "Line Diagnostics" })
nnoremap("<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
nnoremap("gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
  { desc = "Goto Definition" })
nnoremap("gr", function() require("telescope.builtin").lsp_references() end, { desc = "References" })
nnoremap("<leader>cu", function() require("telescope.builtin").lsp_references() end, { desc = "Usage" })
nnoremap("gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
  { desc = "Goto Implementation" })
nnoremap("gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
  { desc = "Goto T[y]pe Definition" })
nnoremap("]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
nnoremap("[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
nnoremap("]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
nnoremap("[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
nnoremap("]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
nnoremap("[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
nnoremap("[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
nnoremap("<leader>cf", vim.lsp.buf.format, { desc = "Format Document" })
nnoremap("<leader>cc", vim.lsp.buf.format, { desc = "Format Document" })


local on_attach = function(_, bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

  nnoremap('gD', vim.lsp.buf.declaration, { silent = true, buffer = bufnr, desc = "Goto Declaration" })
  nnoremap('K', vim.lsp.buf.hover, { silent = true, buffer = bufnr, desc = "Hover" })
  nnoremap('gK', vim.lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "Signature Help" })
  inoremap('<C-k>', vim.lsp.buf.signature_help, { silent = true, buffer = bufnr, desc = "Signature Help" })

  nnoremap('<leader>wa', vim.lsp.buf.add_workspace_folder, { silent = true, buffer = bufnr, desc = "Add Workspace Folder" })
  nnoremap('<leader>wr', vim.lsp.buf.remove_workspace_folder, { silent = true, buffer = bufnr, desc = "Remove Workspace Folder" })
  nnoremap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
   { silent = true, buffer = bufnr, desc = "List Workspace Folders" })
end;


return {
  'neovim/nvim-lspconfig',
  -- event = "VeryLazy",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    'williamboman/mason.nvim', -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/cmp-nvim-lsp',



    'folke/neodev.nvim', -- Lua language server configuration for nvim

  },
  config = function(_, opts)
    -- LSP settings
    require('mason').setup {}
    require('mason-lspconfig').setup({
      --ensure_installed=servers,
      automatic_installation = true
    })
    -- nvim-cmp supports additional completion capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    -- Add nvim-lspconfig plugin
    local lspconfig = require 'lspconfig'

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    end

    require('neodev').setup {}

    lspconfig.lua_ls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    }
  end,
}

