{system, ...}:
{
  imports = [./keymap.nix ./vim_opts.nix ./lsp];

  vim = {
    extraLuaFiles = [./autocmds.lua];

    # Enable/disable
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;
    binds.whichKey.enable = true;
    comments.comment-nvim.enable = true;
    dashboard.startify.enable = true;
    filetree.neo-tree.enable = true;
    git.enable = true;
    notes.todo-comments.enable = true;
    notify.nvim-notify.enable = true;
    statusline.lualine.enable = true;
    telescope.enable = true;
    terminal.toggleterm.enable = true;
    theme.enable = true;
    treesitter.enable = true;
    visuals.indent-blankline.enable = true;

    # Config
    autopairs.nvim-autopairs.setupOpts = {
      map_c_h = true;
      map_c_w = true;
    };
    dashboard.startify.bookmarks = let
      bms = if system == "x86_64-linux" then {
        n = "~/nixos";
      } else {
        n = "~/nix-config/";
      };
    in [ bms ];
    dashboard.startify.changeToVCRoot = true;
    dashboard.startify.lists = [
      {
        type = "dir";
        header = ["MRU"];
      }
      {
        type = "sessions";
        header = ["Sessions"];
      }
      {
        type = "bookmarks";
        header = ["Bookmarks"];
      }
      {
        type = "commands";
        header = ["Commands"];
      }
    ];
    git.gitsigns.codeActions.enable = true;
    theme = {
      name = "catppuccin";
      style = "mocha";
    };
    statusline.lualine.globalStatus = false;
    statusline.lualine.refresh.statusline = 2000;
  };
}
