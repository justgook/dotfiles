local colorschema = {
  -- "navarasu/onedark.nvim",
  -- "folke/tokyonight.nvim",
  "catppuccin/nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  name = "catppuccin",
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
  },

  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme('catppuccin')
  end,
}

local Util = {}
function Util.fg(name)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name }) or vim.api.nvim_get_hl_by_name(name, true)
  local fg = hl and hl.fg or hl.foreground
  return fg and { fg = string.format("#%06x", fg) }
end

local statusline = {
  'nvim-lualine/lualine.nvim',
  event = "VeryLazy",
  opts = function()
    local icons = require("user.config").icons
    return {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = { left = '', right = ""},
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          },
        },
        lualine_x = {
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.fg("Statement"),
          },
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.fg("Constant"),
          },
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.fg("Debug"),
          },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
          },
        },
        lualine_y = {
          { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return " " .. os.date("%R")
          end,
        },
      },
      extensions = { "lazy" },
    }
  end,
}


local noice    = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    presets = {
      bottom_search = true,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = true,
    },
  },
  keys = {
    {
      "<S-Enter>",
      function() require("noice").redirect(vim.fn.getcmdline()) end,
      mode = "c",
      desc =
      "Redirect Cmdline"
    },
    {
      "<leader>snl",
      function() require("noice").cmd("last") end,
      desc =
      "Noice Last Message"
    },
    {
      "<leader>snh",
      function() require("noice").cmd("history") end,
      desc =
      "Noice History"
    },
    { "<leader>sna", function() require("noice").cmd("all") end,     desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    {
      "<c-f>",
      function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end,
      silent = true,
      expr = true,
      desc =
      "Scroll forward",
      mode = {
        "i", "n", "s" }
    },
    {
      "<c-b>",
      function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end,
      silent = true,
      expr = true,
      desc =
      "Scroll backward",
      mode = {
        "i", "n", "s" }
    },
  },
}
local dressing = {
  "stevearc/dressing.nvim",
  -- init = function()
  -- ---@diagnostic disable-next-line: duplicate-set-field
  -- vim.ui.select = function(...)
  --   require("lazy").load({ plugins = { "dressing.nvim" } })
  --   return vim.ui.select(...)
  -- end
  -- ---@diagnostic disable-next-line: duplicate-set-field
  -- vim.ui.input = function(...)
  --   require("lazy").load({ plugins = { "dressing.nvim" } })
  --   return vim.ui.input(...)
  -- end
  -- end,
}

return {
  colorschema,
  statusline,
  noice,
  dressing,
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {}
}

