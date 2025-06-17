{ self, pkgs, inputs, ... }: {
  imports = [
    ./git.nix
    ./nixpkgs.nix
    ./terminal.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  # Basic packages
  home.packages = with pkgs; [
    ffmpeg
    alejandra
    scrcpy

    du-dust
    fd
    hyperfine
    mprocs
    ripgrep
    tokei
    self.packages.${stdenv.system}.neovim
    # self.packages.${stdenv.system}.rebuild
  ];

  # Dotfiles
  home.file = {};

  xdg.configFile = {
    "zellij/config.kdl".source = ../extras/zellij.kdl;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "23.11";
}
