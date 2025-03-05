{ lib, pkgs, ... }: {
  # nixpkgs.config.allowUnfree = true;

  nix = {
    package = lib.mkDefault pkgs.nix;
    gc.automatic = true;
    gc.frequency = "weekly";
  };
  nix.settings = {
    experimental-features = ["nix-command" "flakes" "pipe-operators"];
  };
}
