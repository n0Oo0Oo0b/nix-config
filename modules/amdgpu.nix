{
  ...
}:
{
  nixpkgs.config.rocmSupport = true;

  hardware.graphics.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };
}
