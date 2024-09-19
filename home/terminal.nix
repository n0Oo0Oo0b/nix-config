{
  pkgs,
  lib,
  ...
}: let
  withIntegration = {
    enable = true;
    enableBashIntegration = true;
  };
in {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 12;
    };
    settings = {
      disable_ligatures = "cursor";
    };
  };

  programs.ranger.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.eza = withIntegration;
  programs.gitui.enable = true;
  programs.sioyek.enable = true;
  programs.watson.enable = true;
  programs.keychain = withIntegration;
  programs.starship = withIntegration;
  programs.zellij = withIntegration;

  # programs.starship.settings =
  #   lib.recursiveUpdate
  #   (builtins.fromTOML (builtins.readFile ../extras/starship-nerdfont.toml)) {
  #     os.disabled = false;
  #   };

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  home.shellAliases = {
    cat = "bat";
    glo = "git log --oneline";
  };
}
