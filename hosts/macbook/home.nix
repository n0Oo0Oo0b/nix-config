{ self, pkgs, ... }: {
  imports = [
    # ../../home/discord.nix
    ../../home/git.nix
    ../../home/terminal.nix
    ../../home/vscode.nix
    ../../home/nixpkgs.nix
  ];

  home.username = "danielgu";
  home.homeDirectory = /Users/danielgu;

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  # NOTE: Check home-manager release notes before changing
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # General use
    obsidian
    zotero
    anki-bin

    # # Commandline
    ripgrep
    du-dust
    mprocs
    self.packages.${stdenv.system}.neovim

    # Misc
    ffmpeg
    alejandra
    # blender
    osu-lazer-bin
    prismlauncher
  ];

  programs.nushell.extraLogin = ''
    if not ("__ENV_INIT" in $env) {
      $env.__ENV_INIT = 1
      exec zsh -ilc "exec nu"
    }
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
