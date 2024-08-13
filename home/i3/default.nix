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
    in
      lib.mkOptionDefault {
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${pactl} set-sink-volume 0 +5%";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${pactl} set-sink-volume 0 -5%";
        "XF86AudioMute" = "exec --no-startup-id ${pactl} set-sink-mute 0 toggle";

        "XF86AudioPlay" = "exec ${playerctl} play";
        "XF86AudioPause" = "exec ${playerctl} pause";
        "XF86AudioNext" = "exec ${playerctl} next";
        "XF86AudioPrev" = "exec ${playerctl} previous";

        "${mod}+i" = "focus up";
        "${mod}+shift+i" = "move up";
        "${mod}+j" = "focus left";
        "${mod}+shift+j" = "move left";
        "${mod}+k" = "focus down";
        "${mod}+shift+k" = "move down";
        "${mod}+l" = "focus right";
        "${mod}+shift+l" = "move right";
      };

    startup = let
      no-notif = cmd: {
        command = cmd;
        notification = false;
      };
    in [
      (no-notif "${pkgs.picom}/bin/picom -b")
      (no-notif "${pkgs.flameshot}/bin/flameshot")
      (no-notif "fxitc5 -d")
      (no-notif "${pkgs.feh}/bin/feh --bg-fill $HOME/.background-image" // {always = true;})
      (no-notif "${pkgs.noisetorch}/bin/noisetorch -i")
      (no-notif "${pkgs.openrgb}/bin/openrgb -p default")
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
          text = "#cdd6f4";
          blue = "#89b4fa";
          lavender = "#b4befe";
          red = "#f38ba8";

          bg-text = bg: text: {
            background = bg;
            border = bg;
            text = text;
          };
        in {
          background = mantle;
          focusedWorkspace = bg-text blue text;
          activeWorkspace = (bg-text surface0 crust) // {border = blue;};
          inactiveWorkspace = bg-text surface0 text;
          urgentWorkspace = bg-text red crust;
        };
      }
    ];

    workspaceOutputAssign = let
      left = "DP-2";
      right = "DP-4";
      ws = n: output: {
        workspace = "workspace number ${toString n}";
        output = output;
      };
    in [
      (ws 1 left)
      (ws 2 right)
      (ws 3 left)
      (ws 4 right)
      (ws 5 left)
      (ws 6 right)
      (ws 7 left)
      (ws 8 right)
      (ws 9 left)
      (ws 10 right)
    ];
  };
  xsession.windowManager.i3.extraConfig = ''
    for_window [title="^zoom\s?$"] kill
    for_window [title="^join\?action=join.*$"] kill
  '';

  services.picom = {
    enable = true;
    activeOpacity = 0.95;
    inactiveOpacity = 0.9;
    menuOpacity = 0.9;
  };

  services.flameshot.enable = true;
}
