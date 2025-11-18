{ pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = [ pkgs.wl-clipboard ];
}
