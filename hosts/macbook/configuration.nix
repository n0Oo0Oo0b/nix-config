{self, inputs, pkgs, ...}: {
  imports = [
    # ../../modules/kanata
    ../common.nix
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.overlays = [
    (self: super: {
      # https://github.com/LnL7/nix-darwin/issues/1041
      # karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
      #   version = "14.13.0";
      #   src = super.fetchurl { inherit (old.src) url; hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw="; };
      # });
      # https://github.com/NixOS/nixpkgs/issues/388526
      # obsidian = super.obsidian.overrideAttrs (old: rec {
      #   version = "1.8.7";
      #   src = super.fetchurl {
      #     url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v${version}/Obsidian-${version}.dmg";
      #     hash = "sha256-odpuje7yiEztYG8Yt7oUhR7N7wkdXo8OlglTTMeCz4k=";
      #   };
      # });
    })
  ];

  homebrew.enable = true;
  homebrew.casks = [
    "blackhole-2ch"
    "linearmouse"

    # MS office
    "microsoft-word"
    "microsoft-powerpoint"
    "microsoft-excel"
    "microsoft-onenote"
    "microsoft-teams"
    "onedrive"

    # Misc
    "wechat"
    "steam"
    "blender"
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

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

  ids.gids.nixbld = 30000;

  system.stateVersion = 6;
}
