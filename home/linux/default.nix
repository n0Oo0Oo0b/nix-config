{ pkgs, ... }:
{
  imports = [
    # ./i3
    ./rofi.nix
    ./wayland
  ];

  services.flameshot = {
    enable = true;
    package = pkgs.flameshot.override { enableWlrSupport = true; };
  };
}
