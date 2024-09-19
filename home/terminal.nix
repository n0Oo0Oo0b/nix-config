{
  pkgs,
  lib,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    profileExtra = ''
      eval $(ssh-agent) &>/dev/null
      export NIXPKGS_ALLOW_UNFREE=1
      eval "$(starship init bash)"
    '';
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
  programs.eza.enable = true;
  programs.gitui.enable = true;
  programs.sioyek.enable = true;
  programs.watson.enable = true;

  programs.starship = {
    enable = true;
    settings =
      lib.recursiveUpdate
      (builtins.fromTOML (builtins.readFile ../extras/starship-nerdfont.toml)) {
        os.disabled = false;
      };
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    ls = "eza";
    cat = "bat";
    glo = "git log --oneline";
  };
}
