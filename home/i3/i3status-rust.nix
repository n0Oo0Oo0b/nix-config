{
  programs.i3status-rust = {
    enable = true;
    bars.bottom = {
      blocks = let
        replace_idle_with = to: {
          idle_fg = {link = "${to}_fg";};
          idle_bg = {link = "${to}_bg";};
        };
      in [
        {
          block = "disk_space";
          path = "/";
          format = " $icon $used/$total ";
          info_type = "available";
          interval = 60;
          warning = 20.0;
          alert = 10.0;
          alert_unit = "GB";
        }

        {
          block = "memory";
          format = " $icon $mem_used.eng(prefix:G)/$mem_total.eng(prefix:G) ";
          warning_mem = 70.0;
          critical_mem = 90.0;
        }

        {
          block = "cpu";
          format = " $icon $utilization ";
          format_alt = " $icon $barchart ";
          interval = 1;
        }

        {
          block = "temperature";
          interval = 5;
          good = 45;
          format = " $max ";
          format_alt = " $min | $average | $max ";
        }

        {
          block = "nvidia_gpu";
          format = " $icon $utilization $temperature ";
        }

        {
          block = "net";
          format_alt = " $icon ^icon_net_down $graph_down ^icon_net_up $graph_up ";
          theme_overrides = replace_idle_with "good";
        }

        {
          block = "sound";
          driver = "pulseaudio";
          format = " $icon $output_name{ $volume|} ";
          max_vol = 200;
          mappings_use_regex = true;
          mappings = {
            "alsa_output.usb-0b0e_Jabra_SPEAK_510_USB_305075A7C4D0022000-00.analog-stereo" = "Speaker";
            "alsa_output.pci-0000_01_00.1.hdmi-stereo-extra1.[0-9]+" = "Monitor";
          };
          theme_overrides = replace_idle_with "warning";
        }

        {
          block = "time";
          interval = 1;
          format = " $icon $timestamp.datetime(f:'%a %Y-%m-%d %T') ";
          theme_overrides = replace_idle_with "info";
        }

        {block = "watson";}

        {
          block = "menu"; # System menu
          text = " hi ";
          items = [
            {
              display = " Sleep ";
              cmd = "systemctl suspend";
            }
            {
              display = " Power off ";
              cmd = "poweroff";
              confirm_msg = "Confirm poweroff";
            }
            {
              display = " Reboot ";
              cmd = "reboot";
              confirm_msg = "Confirm reboot";
            }
          ];
          theme_overrides = replace_idle_with "critical";
        }
      ];
      theme = "ctp-mocha";
      icons = "material-nf";
    };
  };
}
