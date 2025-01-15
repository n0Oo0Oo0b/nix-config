vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "CursorMovedI", "ModeChanged" }, {
    desc = "Refresh lualine contents",
    callback = function(_)
        require("lualine").refresh({ place = { "statusline" } });
    end,
});
