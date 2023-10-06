require('user.config.options')
require('user.config.autocmds')
require('user.config.keymap')
require('user.config')


local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable',
    lazypath }
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  spec = { import = "user.plugins" },
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",   -- lockfile generated after running update.

  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false,     -- get a notification when changes are found
  },
})

