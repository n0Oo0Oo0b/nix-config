-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "lervag/vimtex", lazy = false },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "savq/melange-nvim", lazy = false },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
  }
})

-- Leftover vimscript config
vim.cmd([[
  imap <C-Space> <Right><Esc>
  vmap <C-Space> <Esc>
  nmap H ^
  nmap L $

  set number relativenumber
  
  set textwidth=0 wrap wrapmargin=0
  set linebreak
  set columns=80

  set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab

  colorscheme melange

  let g:vimtex_view_method = 'sioyek'
  let g:vimtex_callback_progpath = 'nvim'
]])
