{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;

    keymaps = import ./keymaps.nix;
    opts = import ./opts.nix;
    userCommands = import ./commands.nix;
    autoCmd = import ./autocmds.nix;
    plugins = import ./plugins;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    colorschemes.catppuccin.enable = true;
    colorschemes.catppuccin.settings = {
      flavour = "mocha";
    };

    clipboard.providers.xclip.enable = true;

    extraPackages = with pkgs; [
      lua-language-server
      ruff
    ];

  };
}
