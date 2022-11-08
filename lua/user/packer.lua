-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- plugins dependencies
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    -- Theme / colors / icons
    use 'folke/tokyonight.nvim'
    use 'nvim-tree/nvim-web-devicons'


    use 'nvim-treesitter/nvim-treesitter'
    -- use 'nvim-treesitter/nvim-treesitter-context'
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }   
    --telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }



    -- Project directory
    use "ahmedkhalf/project.nvim"

    use "numToStr/Comment.nvim" -- Easily comment stuff
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
