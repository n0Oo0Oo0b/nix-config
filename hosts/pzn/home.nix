{ pkgs, ... }: {
  imports = [
    ../../home/common
  ];

  home.username = "pansternoob";
  home.homeDirectory = "/home/pansternoob";

  home.packages = with pkgs; [
    tmux
    (callPackage ../../home/common/rebuild-script.nix { hostname = "pzn"; system = "x86_64-linux"; })
  ];

  # Dotfiles
  home.file = {};
}
