{ ... }: {
  vim = {
    autopairs.nvim-autopairs.setupOpts = {
      map_c_h = true;
      map_c_w = true;
    };

    dashboard.startify.bookmarks = [
        { n = "~/nix-config"; }
    ];
    dashboard.startify.changeToVCRoot = true;
    dashboard.startify.lists = let
      mkTypeHeader = type: header: { inherit type header; };
    in [
      (mkTypeHeader "dir" ["MRU"])
      (mkTypeHeader "sessions" ["Sessions"])
      (mkTypeHeader "bookmarks" ["Bookmarks"])
      (mkTypeHeader "commands" ["Commands"])
    ];

    git.gitsigns.codeActions.enable = true;
    theme = {
      name = "catppuccin";
      style = "mocha";
    };

    statusline.lualine.globalStatus = false;
    statusline.lualine.refresh.statusline = 2000;

    lsp.formatOnSave = true;
    treesitter.highlight.enable = true;
    treesitter.indent.enable = true;

    languages.rust.lsp.package = [ "rust-analyzer" ];
  };
}
