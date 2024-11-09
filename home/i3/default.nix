{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./i3status-rust.nix
  ];

  xsession.enable = true;
  xsession.initExtra = ''
    LEFT='DP-2'
    RIGHT='DP-4'
    ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --primary --right-of $LEFT --mode 2560x1440 --rate 144 --output $LEFT --mode 1920x1080 --rate 75 --rotate left
    ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --pos 1080x240
  '';

  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.config = {
    modifier = "Mod4";
    fonts = {
      names = ["JetBrains Mono Nerd Font"];
      style = "Regular";
      size = 11.0;
    };
    terminal = "kitty";

    gaps.inner = 10;
    gaps.outer = 5;

    keybindings = let
      pactl = "${pkgs.pulseaudio}/bin/pactl";
      playerctl = "${pkgs.playerctl}/bin/playerctl";
      mod = config.xsession.windowManager.i3.config.modifier;
      rofi = "${config.programs.rofi.finalPackage}/bin/rofi";
    in
      lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pactl} set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pactl} set-sink-volume 0 -5%";
        "XF86AudioMute" = "exec --no-startup-id ${pactl} set-sink-mute 0 toggle";

        "XF86AudioPlay" = "exec ${playerctl} play";
        "XF86AudioPause" = "exec ${playerctl} pause";
        "XF86AudioNext" = "exec ${playerctl} next";
        "XF86AudioPrev" = "exec ${playerctl} previous";

        "${mod}+shift+f" = "exec firefox";
        "${mod}+shift+o" = "exec obsidian";
        "${mod}+shift+d" = "exec discord";
        "${mod}+F11" = "exec set-sink hdmi-stereo";
        "${mod}+F12" = "exec set-sink Jabra_SPEAK_510";

        "${mod}+v" = null;
        "${mod}+bracketleft" = "split horizontal";
        "${mod}+bracketright" = "split vertical";

        "${mod}+k" = "focus up";
        "${mod}+shift+k" = "move up";
        "${mod}+h" = "focus left";
        "${mod}+shift+h" = "move left";
        "${mod}+j" = "focus down";
        "${mod}+shift+j" = "move down";
        "${mod}+l" = "focus right";
        "${mod}+shift+l" = "move right";

        "${mod}+shift+s" = "exec flameshot gui";

        "${mod}+d" = null;
        "${mod}+space" = "exec ${rofi} -show drun";
        "${mod}+c" = "exec ${rofi} -modi calc -show calc -no-show-match -no-sort";
      };

    startup = let
      no-notif = cmd: {
        command = cmd;
        notification = false;
      };
    in [
      (no-notif "${pkgs.picom}/bin/picom -b")
      (no-notif "${pkgs.flameshot}/bin/flameshot")
      (no-notif "${pkgs.feh}/bin/feh --bg-fill $HOME/.background-image" // {always = true;})
      (no-notif "${pkgs.noisetorch}/bin/noisetorch -i")
      (no-notif "${pkgs.openrgb}/bin/openrgb -p default")
      (no-notif "/run/current-system/sw/bin/fcitx5")
    ];

    bars = [
      {
        position = "bottom";
        statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
        trayOutput = "primary";
        # Catppuccin-mocha
        colors = let
          crust = "#11111b";
          mantle = "#181825";
          base = "#1e1e2e";
          surface0 = "#313244";
          surface1 = "#45475a";
          text = "#cdd6f4";
          blue = "#89b4fa";
          lavender = "#b4befe";
          red = "#f38ba8";

          bg-border-text = bg: border: text: {
            background = bg;
            border = border;
            text = text;
          };
        in {
          background = mantle;
          focusedWorkspace = bg-border-text blue blue crust;
          activeWorkspace = bg-border-text surface1 blue text;
          inactiveWorkspace = bg-border-text surface0 surface0 text;
          urgentWorkspace = bg-border-text red red crust;
        };
      }
    ];

    workspaceOutputAssign = let
      left = "DP-4";
      right = "DP-2";
      ws = n: output: {
        workspace = n;
        output = output;
      };
    in [
      (ws "1" left)
      (ws "2" right)
      (ws "3" left)
      (ws "4" right)
      (ws "5" left)
      (ws "6" right)
      (ws "7" left)
      (ws "8" right)
      (ws "9" left)
      (ws "10" right)
    ];
  };

  xsession.windowManager.i3.extraConfig = ''
    for_window [title="^zoom\s?$"] kill
    for_window [title="^join\?action=join.*$"] kill
    no_focus [title=".*[zZ]oom.*"]
    no_focus [title="^join\?action=join.*$"]

    for_window [title="^Minecraft .*$"] floating enable

    no_focus [class="flameshot"]
  '';

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    plugins = [pkgs.rofi-calc];
    catppuccin.flavor = "macchiato";
    theme = {
      "*".width = "600px";
      "*".font = "monospace 12";
      window.height = "720px";
    };
  };

  services.picom = {
    enable = true;
    activeOpacity = 1;
    inactiveOpacity = 0.9;
    menuOpacity = 0.9;
  };

  services.flameshot.enable = true;
}
