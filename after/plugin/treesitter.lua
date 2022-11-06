require('nvim-treesitter.configs').setup {
    -- one of "all", "maintained" (parsers with maintainers),
    -- or a list of languages
    ensure_installed = {  "c", "lua", "comment" },
    highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },

    
    indent = {
        enable = true
    },

    autotag = {
        enable = true,
    }
}
vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.libsonnet" }, command = "setfiletype jsonnet" }
)


--vim.opt.foldmethod = "expr"
--vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
--vim.wo.foldcolumn = "1"
--vim.opt.foldenable = false
