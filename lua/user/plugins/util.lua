local clueOpts = function()
  local miniclue = require("mini.clue")

  return {
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },
      -- `prev` key
      { mode = 'n', keys = '[' },
      { mode = 'x', keys = '[' } ,
      -- `next` key
      { mode = 'n', keys = ']' },
      { mode = 'x', keys = ']' },
      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      { mode = 'n', keys = '<Leader>w', desc="Workspace"},
      { mode = 'n', keys = '<Leader>s', desc="Search"},
      { mode = 'n', keys = '<Leader>sn', desc="Noice"},
      { mode = 'n', keys = '<Leader>f', desc="File/Find"},
      { mode = 'n', keys = '<Leader>x', desc="Diagnostics/Quickfix"},
      { mode = 'n', keys = '<Leader>g', desc="Git"},
      { mode = 'n', keys = '<Leader>gh', desc="Hunks"},
      { mode = 'n', keys = '<Leader>c', desc="Code"},
      { mode = 'n', keys = '<Leader>u', desc="UI"},
      { mode = 'n', keys = '[', desc="Noice"},
      { mode = 'n', keys = ']', desc="Noice"},
        --      ["<lceader><tab>"] = { name = "+tabs" },
        -- ["<leader>b"] = { name = "+buffer" },
        -- ["<leader>q"] = { name = "+quit/session" },
        -- ["<leader>s"] = { name = "+search" },
        -- ["<leader>w"] = { name = "+windows" },
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),

    },
    window = {
      delay = 100,
      config = {
        width = 'auto',
        border = "double",
      },
    }
  }
end

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
    float = { border = "rounded" },
})


return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.pairs').setup()
    require('mini.comment').setup()
    require('mini.surround').setup()
    require('mini.trailspace').setup()
    require('mini.clue').setup(clueOpts())
    require('mini.files').setup()
    -- require('mini.completion').setup()
  end,
}

