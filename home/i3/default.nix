{...}: {
  xsession = {
    enable = true;
    windowManager.i3.enable = true;
    windowManager.i3.config = {
      modifier = "Mod4";
      fonts = ["JetBrains Mono Nerd Font 11.0"];
      startup = [
        {command = "bash $HOME/.screenlayout/monitor.sh";}
        {command = "noisetorch -i";}
        {command = "openrgb -p default";}
      ];
    };
    # Path, relative to HOME, where Home Manager should write the X session script.
    # and NixOS will use it to start xorg session when system boot up
    scriptPath = ".xsession";
  };

  home.file = {
    ".screenlayout/monitor.sh".text = ''
      #!/bin/sh
      LEFT='DP-2'
      RIGHT='DP-3'
      xrandr --output $RIGHT --primary --right-of $LEFT --mode 2560x1440 --rate 144 --output $LEFT --mode 1920x1080 --rate 75 --rotate left
      xrandr --output $RIGHT --pos 1080x240
    '';
  };
}
