
local function telescope(fn, opts)
  local params = { builtin = fn, opts = opts }
  return function ()
    local builtin = params.builtin
    opts = params.opts
    opts = vim.tbl_deep_extend("force",{}, opts or {})
    if builtin == "files" then
      if vim.loop.fs_stat((opts.cwd or vim.loop.cwd()) .. "/.git") then
        opts.show_untracked = true
        builtin = "git_files"
      else
        builtin = "find_files"
      end
    end
    if opts.cwd and opts.cwd ~= vim.loop.cwd() then
      opts.attach_mappings = function(_, map)
        map("i", "<a-c>", function()
          local action_state = require("telescope.actions.state")
          local line = action_state.get_current_line()
          telescope(
            params.builtin,
            vim.tbl_deep_extend("force", {}, params.opts or {}, { cwd = false, default_text = line })
          )()
        end)
        return true
      end
    end
    require("telescope.builtin")[builtin](opts)
  end
end



local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

return { -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim',
    version = false, -- telescope did only one release, so use HEAD for now
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
      { "<leader>/", telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>:", telescope("command_history"), desc = "Command History" },

      { "<leader><space>", telescope("files"), desc = "Find Files (root dir)" },
      -- find
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>ff", telescope("files"), desc = "Find Files (root dir)" },
      { "<leader>fF", telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fR", telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
      -- search
      { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
      { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
      { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
      { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sg", telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
      { "<leader>sw", telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
      { "<leader>sW", telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
      { "<leader>sw", telescope("grep_string", { default_text="get_visual_selection" }), mode = "v", desc = "Selection (root dir)" },
      { "<leader>sW", telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
      { "<leader>uC", telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
      {
        "<leader>ss",
        telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
opts={
        pickers = {
          command_history = {
            theme = "dropdown",
            winblend = 10,
          }
        },
        defaults = {
          mappings = {
            i = {
              ["<c-t>"] = function(...)
                return require("trouble.providers.telescope").open_with_trouble(...)
              end,
              ["<a-t>"] = function(...)
                return require("trouble.providers.telescope").open_selected_with_trouble(...)
              end,
              ["<a-i>"] = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                telescope("find_files", { no_ignore = true, default_text = line })()
              end,
              ["<a-h>"] = function()
                local action_state = require("telescope.actions.state")
                local line = action_state.get_current_line()
                telescope("find_files", { hidden = true, default_text = line })()
              end,
              ["<C-Down>"] = function(...)
                return require("telescope.actions").cycle_history_next(...)
              end,
              ["<C-Up>"] = function(...)
                return require("telescope.actions").cycle_history_prev(...)
              end,
              ["<C-f>"] = function(...)
                return require("telescope.actions").preview_scrolling_down(...)
              end,
              ["<C-b>"] = function(...)
                return require("telescope.actions").preview_scrolling_up(...)
              end,
            },
            n = {
              ["q"] = function(...)
                return require("telescope.actions").close(...)
              end,
            },
          },
        },
      },
    config = function(_, opts)
      require('telescope').setup(opts)

      -- Enable telescope fzf native
      require('telescope').load_extension 'fzf'
      --require('telescope').load_extension('projects')
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you have trouble with this installation, refer to the README for telescope-fzf-native.
    build = 'make',
  },
}

