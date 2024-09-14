{
  pkgs,
  lib,
  ...
}: {
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
}
