return {
  {
    'christoomey/vim-tmux-navigator',
    -- lazy = false,
    keys = {
      {"<C-k>", "<cmd>TmuxNavigateUp<cr>", desc="window up"},
      {"<C-l>", "<cmd>TmuxNavigateRight<cr>", desc="window right"},
      {"<C-j>", "<cmd>TmuxNavigateDown<cr>", desc="window down"},
      {"<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc="window left"},
    },
  }
}

