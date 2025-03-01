{ self, pkgs, inputs, ... }: {
  imports = [
    #../../home/discord.nix
    ../../home/git.nix
    ../../home/terminal.nix
    ../../home/vscode.nix
  ];

  home.username = "danielgu";

  # NOTE: Check home-manager release notes before changing
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    # General use
    obsidian
    zotero
    anki-bin

    # Commandline
    porsmo
    ripgrep
    du-dust
    mprocs
    self.packages.${stdenv.system}.neovim

    # Misc
    ffmpeg
    alejandra
    davinci-resolve
    blender
    osu-lazer-bin
    prismlauncher
    rquickshare
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
