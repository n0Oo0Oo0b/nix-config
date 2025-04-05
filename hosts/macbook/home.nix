{ pkgs, ... }: {
  imports = [
    ../../home/common
    ../../home/gui
  ];

  home.username = "danielgu";
  home.homeDirectory = /Users/danielgu;

  home.packages = with pkgs; [
    # Misc
    google-chrome

    # Darwin-specific
    ice-bar
    raycast
    zoom-us
    jetbrains.idea-ultimate
  ];

  # Init env vars with zsh
  programs.nushell.extraLogin = ''
    if not ("__ENV_INIT" in $env) {
      $env.__ENV_INIT = 1
      exec zsh -ilc "exec nu"
    }
  '';
}
