{
  pkgs,
  lib,
  ...
}: let
  withIntegration = other:
    {
      enable = true;
      enableBashIntegration = true;
    }
    // other;
in {
  # Base
  programs.bash.enable = true;
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

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  home.shellAliases = {
    cat = "bat";
    glo = "git log --oneline";
  };

  # Terminal programs
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.eza = withIntegration {};
  programs.gitui.enable = true;
  programs.keychain = withIntegration {keys = ["id_ed25519"];};
  programs.nix-index = withIntegration {};
  programs.ranger.enable = true;
  programs.sioyek.enable = true;
  programs.starship = withIntegration {
    settings =
      lib.recursiveUpdate
      (builtins.fromTOML (builtins.readFile ../extras/starship-nerdfont.toml)) {
        os.disabled = false;
      };
  };
  programs.watson.enable = true;
  programs.zellij = withIntegration {};
  programs.zoxide = withIntegration {};
}
