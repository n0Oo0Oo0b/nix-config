{ config, pkgs, inputs, ... }: {
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
    (blender.override {cudaSupport = true;})
    wechat-uos
    gimp

    # Linux-specific
    inputs.zen-browser.packages.${stdenv.system}.default
    davinci-resolve
    pulseaudio
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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      input-overlay
    ];
  };
}
