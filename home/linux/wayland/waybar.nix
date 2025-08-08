{ ... }:
{
  programs.waybar = {
    enable = true;
    settings.mainbar = {
      position = "top";
      exclusive = true;

      modules-left = [
        "hyprland/workspaces"
        "tray"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "cpu"
        "temperature#cpu"
        "memory"
        "network"
        "pulseaudio"
      ];

      clock = {
        format-alt = "{:%a, %d. %b  %H:%M}";
      };

      cpu = {
        interval = 1;
        format-alt = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}{icon12}{icon13}{icon14}{icon15}";
        format-icons = [
          " "
          "▁"
          "▂"
          "▃"
          "▄"
          "▅"
          "▆"
          "▇"
          "█"
        ];
        states = {
          warning = 20;
          critical = 50;
        };
      };

      "temperature#cpu" = {
        interval = 1;
        hwmon-path = "/sys/class/thermal/thermal_zone0/temp";
        critical-threshold = 70;
        format = "{icon} {temperatureC}°";
        format-icons = [ "" ];
      };

      tray = {
        icon-size = 18;
        spacing = 8;
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
      }

      #waybar>box {
        border-radius: 0;
        border: 0;
        background-color: @mantle;
      }

      #clock, #tray, #workspaces, .modules-right {
        border-radius: 1.5em;
        border: 2px solid @overlay0;
        background-color: transparent;
        font-weight: 600;
        color: @text;
      }
      .modules-right {
        background-color: @base;
      }

      #clock { padding: 0 1em; background-color: @base; }

      #tray { padding: 0 0.5em; }

      #cpu, #temperature, #memory, #network, #pulseaudio { margin: 0.25em; }

      #workspaces button {
        padding: 0 0.4em;
        margin: 0.15em;
        border-radius: 1em;
        background-color: @surface0;
        border: 2px solid @surface0;
      }
      #workspaces button.empty { color: @overlay0; }
      #workspaces button.visible { border-color: @blue; }
      #workspaces button.active { background-color: @blue; color: @surface0; }
      #workspaces button.urgent { background-color: @red; color: @surface0; }
    '';
  };
}
