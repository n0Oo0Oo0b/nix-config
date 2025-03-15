{ pkgs, inputs, ... }: {
  imports = [
    # ../../home/discord.nix
    ../../home/common
    ../../home/discord.nix
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.username = "danielgu";
  home.homeDirectory = /Users/danielgu;

  # NOTE: Check home-manager release notes before changing
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # Misc
    google-chrome

    # Darwin-specific
    ice-bar
    raycast
    zoom-us
    jetbrains.idea-ultimate
  ];

  # Init env vars with zsh
  programs.nushell.extraLogin = ''
    if not ("__ENV_INIT" in $env) {
      $env.__ENV_INIT = 1
      exec zsh -ilc "exec nu"
    }
  '';
}
