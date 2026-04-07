{ pkgs, ... }:
let
  tfchooser = pkgs.xdg-desktop-portal-termfilechooser;
in
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;

    config.preferred."org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
    extraPortals = [ tfchooser ];
  };

  hm.xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${tfchooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    env=TERMCMD=kitty
    default_dir=$HOME/Downloads
  '';
}
