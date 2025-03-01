{self, inputs, pkgs, ...}: {
  imports = [
    ../common.nix
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";

  # fonts.packages = with pkgs; [
  #   nerd-fonts.jetbrains-mono
  #   inter
  #   noto-fonts
  #   noto-fonts-cjk-sans
  #   noto-fonts-cjk-serif
  # ];

  users.users.danielgu = {
    description = "Daniel Gu";
    home = /Users/danielgu;
    shell = pkgs.nushell;
  };

  home-manager = {
    extraSpecialArgs = {inherit self inputs;};
    users.danielgu = import ./home.nix;
  };

  environment.systemPackages = with pkgs; [
    wget
    unzip
    nushell
  ];
  environment.shells = [
    "${pkgs.nushell}/bin/nu"
  ];

  services.openssh.enable = true;

  system.stateVersion = 6;
}
