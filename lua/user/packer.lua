-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Theme / colors / icons
    use 'folke/tokyonight.nvim'
    use 'nvim-tree/nvim-web-devicons'

    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'

    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'
    use {
        "windwp/nvim-autopairs",
        wants = "nvim-treesitter",
        module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },

        config = function() require("nvim-autopairs").setup() end
    }

    -- use {
    --     "folke/twilight.nvim",
    --     config = function()
    --         require("twilight").sestup {
    --             -- `Twilight` : toggle twilight
    --             -- your configuration comes here
    --             -- or leave it empty to use the default settings
    --             -- refer to the configuration section below
    --         }
    --     end
    -- }

    --Fuzzy Finding
    use 'nvim-lua/telescope.nvim'
    -- Nice view for keys (good why learning vim)
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
end)
