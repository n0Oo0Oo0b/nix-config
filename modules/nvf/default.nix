{ ... }:
{
  imports = [
    ./config.nix
    ./keymap.nix
    ./vim_opts.nix
    ./extra_plugins.nix
  ];

  vim = {
    extraLuaFiles = [ ./cmds.lua ];

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
    utility.surround.enable = true;
    # utility.vim-wakatime.enable = true;
    visuals.indent-blankline.enable = true;

    # Misc LSP
    lsp.enable = true;
    lsp.lspSignature.enable = true;
    lsp.otter-nvim.enable = true;
    languages.enableTreesitter = true;

    # Languages
    languages = {
      clang.enable = true;
      clang.cHeader = true;
      css.enable = true;
      html.enable = true;
      java.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nix.enable = true;
      nu.enable = true;
      python.enable = true;
      rust.enable = true;
      wgsl.enable = true;
    };
  };
}
