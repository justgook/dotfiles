local  snipSnip =  {
    'L3MON4D3/LuaSnip',
    lazy=true,
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    config = function()
        local luasnip = require 'luasnip'
        luasnip.config.setup {}
        require("luasnip.loaders.from_vscode").lazy_load()
    end,
}

-- Autocompletion
local M = {
    'hrsh7th/nvim-cmp',
    dependencies = {
        "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-path',

        { 'saadparwaiz1/cmp_luasnip', dependencies = { 'L3MON4D3/LuaSnip' } },
    },
}

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local kind_icons = require("user.config").icons.kinds

local formatting = {
    format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            luasnip = "[LuaSnip]",
            nvim_lua = "[Lua]",
            latex_symbols = "[LaTeX]",
        })[entry.source.name]
        return vim_item
    end
}
M.config = function()
    local luasnip = require 'luasnip'
    -- Set completeopt to have a better completion experience
    local cmp = require("cmp")

    vim.o.completeopt = 'menuone,noselect'
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },
        formatting = formatting,
        window = {
            completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif has_words_before() then
                    cmp.complete()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        },

        sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'buffer' },

        },
    })
    -- `:` cmdline setup.
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            {
                name = 'cmdline',
                option = {
                    ignore_cmds = { 'Man', '!' }
                }
            }
        })
    })
    cmp.setup.cmdline('/', {
        -- view = {
        --     entries = {name = 'wildmenu', separator = '|' }
        -- },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })
end;


return {
  snipSnip, M
}

