{
  pkgs,
  lib,
  ...
}: let
  withIntegration = other:
    {
      enable = true;
      enableNushellIntegration = true;
    }
    // other;
in rec {
  # Base
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 12;
    };
    settings = {
      disable_ligatures = "cursor";
      shell = "nu -i -l";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
    ZELLIJ_AUTO_EXIT = "true";
    _ZO_FZF_OPTS = "+e";
  };

  home.shellAliases = {
    glo = "git log --oneline";
    gs = "git status";
  };

  # CLI programs
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.carapace = withIntegration {};
  programs.direnv = withIntegration {nix-direnv.enable = true;};
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.gitui.enable = true;
  programs.keychain = withIntegration {keys = ["id_ed25519"];};
  programs.nix-index.enable = true;
  programs.ranger.enable = true;
  programs.sioyek.enable = true;
  programs.starship = withIntegration {
    settings =
      lib.recursiveUpdate
      (builtins.fromTOML (builtins.readFile ../extras/starship-nerdfont.toml)) {
        continuation_prompt = "┆ ";
      };
  };
  programs.watson.enable = true;
  programs.zellij.enable = true;
  programs.zoxide = withIntegration {};

  programs.sioyek.bindings = {
    "screen_down" = ["d" "<c-d>"];
    "screen_up" = ["u" "<c-u>"];
  };

  # Nushell config
  programs.nushell = {
    enable = true;
    extraConfig = builtins.readFile ../extras/config.nu;
    # Manual shell stuff
    shellAliases = home.shellAliases;
    extraEnv = builtins.concatStringsSep "\n" (
      lib.attrsets.mapAttrsToList
      (name: value: "$env.${name} = \"${toString value}\"")
      home.sessionVariables
    );
    loginFile.text = ''
    '';
  };
}
