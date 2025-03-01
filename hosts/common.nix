{...}: {
  time.timeZone = "Asia/Shanghai";

  nix.settings = {
    substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
    ];
    builders-use-substitutes = true;

    experimental-features = ["nix-command" "flakes" "pipe-operators"];
  };

  nix.optimise.automatic = true;

  nix.gc = {
    automatic = true;
    interval = [{ Weekday = 7; }];
    options = "--delete-older-than 3d";
  };

  nixpkgs.config.allowUnfree = true;
}
