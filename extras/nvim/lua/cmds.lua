-- [[ User Commands ]]

local add_cmd = vim.api.nvim_create_user_command

add_cmd('I2s', function()
  vim.bo.expandtab = true
  vim.bo.tabstop = 2
end, { desc = "Set indentation to 2 spaces" })

add_cmd('I4s', function()
  vim.bo.expandtab = true
  vim.bo.tabstop = 4
end, { desc = "Set indentation to 4 spaces" })


-- [[ Autocommands ]]

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
