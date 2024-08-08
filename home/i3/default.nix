{pkgs, ...}: {
  xsession = {
    enable = true;
    windowManager.i3.enable = true;
    windowManager.i3.config = {
      modifier = "Mod4";
      fonts = ["JetBrains Mono Nerd Font 11.0"];
      terminal = "kitty";
    };

    initExtra = ''
      LEFT='DP-2'
      RIGHT='DP-4'
      ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --primary --right-of $LEFT --mode 2560x1440 --rate 144 --output $LEFT --mode 1920x1080 --rate 75 --rotate left
      ${pkgs.xorg.xrandr}/bin/xrandr --output $RIGHT --pos 1080x240
    '';
    profileExtra = ''
      ${pkgs.noisetorch}/bin/noisetorch -i
      ${pkgs.openrgb}/bin/openrgb -p default
    '';
  };
}
