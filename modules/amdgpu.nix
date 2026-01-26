{
  ...
}:
{
  nixpkgs.config.rocmSupport = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # services.xserver = {
  #   enable = true;
  #   videoDrivers = [ "amdgpu" ];
  # };
}
