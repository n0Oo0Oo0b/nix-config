{...}: {
  xsession = {
    enable = true;
    windowManager.i3.enable = true;
    windowManager.i3.config = {
      modifier = "Mod4";
      fonts = ["JetBrains Mono Nerd Font 11.0"];
      terminal = "kitty";
    };
    profileExtra = ''
      bash ~/.screenlayout/monitor.sh
      noisetorch -i
      openrgb -p default
    '';
  };
}
