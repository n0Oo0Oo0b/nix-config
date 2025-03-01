{...}: {
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    frequency = "weekly";
  };
}
