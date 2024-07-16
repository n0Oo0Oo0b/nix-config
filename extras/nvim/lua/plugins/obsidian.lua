return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  -- ft = "markdown",
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufReadPre "
    .. vim.fn.expand("~")
    .. "/Desktop/obsidian-main/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Desktop/obsidian-main/**.md",
    "BufReadPre " .. vim.fn.expand("~") .. "/Documents/mapadoodledoo/documentation/**.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/mapadoodledoo/documentation/**.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "obsidian-main",
        path = "~/Desktop/obsidian-main",
      },
      {
        name = "mapadoodledoo",
        path = "~/Documents/mapadoodledoo/documentation/",
      },
    },
  },
}
