-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require("lazy").setup({
  require("plugins.lsp"),
  require("plugins.telescope"),
  require("plugins.treesitter"),
  require("plugins.autocomplete"),
  require("plugins.autoformat"),
  require("plugins.misc"),

  -- require 'plugins.debug',
  require("plugins.indent_line"),
  require("plugins.lint"),
  require("plugins.autopairs"),
  -- require 'plugins.neo-tree',
  require("plugins.gitsigns"), -- adds gitsigns recommend keymaps

  require("plugins.colorscheme"),
  require("plugins.venv-selector"),
  -- require("plugins.obsidian"),
}, {
  ui = {
    icons = {},
  },
})
