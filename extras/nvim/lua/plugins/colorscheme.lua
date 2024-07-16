return {
    {
        'folke/tokyonight.nvim',
        priority = 1000, -- Make sure to load this before all the other start plugins.
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        init = function()
            vim.cmd.colorscheme 'tokyonight-night'
        end,
    },
    {
        "savq/melange-nvim",
        priority = 1000,
    },
}
