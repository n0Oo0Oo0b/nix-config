{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../home/common
    ../../home/gui
    ../../home/linux
  ];

  home.username = "danielgu";
  home.homeDirectory = "/home/danielgu";

  home.packages = with pkgs; [
    # Misc
    porsmo
    godot_4
    libreoffice
    (blender.override { cudaSupport = true; })
    wechat-uos
    # gimp
    (callPackage ../../home/common/rebuild-script.nix {
      hostname = "nixos";
      system = "x86_64-linux";
    })

    # Linux-specific
    inputs.zen-browser.packages.${stdenv.system}.default
    davinci-resolve
  ];

  gtk = {
    enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk2.extraConfig = "gtk-application-prefer-dark-theme=true";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };
  catppuccin.gtk.enable = true;
  catppuccin.gtk.icon.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}
