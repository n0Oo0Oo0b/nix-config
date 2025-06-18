vim.api.nvim_create_autocmd({ "BufEnter", "CursorMoved", "CursorMovedI", "ModeChanged" }, {
    desc = "Refresh lualine contents",
    callback = function(_)
        require("lualine").refresh({ place = { "statusline" } });
    end,
});

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight yanked text",
    callback = function()
        vim.highlight.on_yank();
    end,
})

vim.api.nvim_create_user_command("Is", function(cmd)
    vim.bo.expandtab = true;
    vim.bo.tabstop = tonumber(cmd.args);
    vim.bo.shiftwidth = 0;
end, { nargs = 1, desc = "Set indentation to <N> spaces" });


-- Monkeypatch nushell + wakatime
vim.api.nvim_create_augroup("WakaTimeNushellFix", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
    group = "WakaTimeNushellFix",
    callback = function()
        if ! vim.o.shell:match("nu") then return end
        vim.cmd([[
            " Replace the plugin's shellescape-based sanitizer
            function! s:SanitizeArg(arg) abort
              " only escape spaces, leave everything else alone
              return substitute(a:arg, ' ', '\\ ', 'g')
            endfunction

            " Replace its JoinArgs to use our new sanitizer
            function! s:JoinArgs(args) abort
              return join(map(a:args, 's:SanitizeArg(v:val)'), ' ')
            endfunction
        ]])
    end,
})
