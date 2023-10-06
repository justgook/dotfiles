return {
  'nvim-treesitter/nvim-treesitter',   -- Highlight, edit, and navigate code
  -- dependencies={
  --     'nvim-treesitter/nvim-treesitter-textobjects', -- Additional textobjects for treesitter
  -- },
  opts = {
    highlight = {
      enable = true,       -- false will disable the whole extension
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require 'nvim-treesitter.configs'.setup(opts)
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end
}
