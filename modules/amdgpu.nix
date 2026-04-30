{
  ...
}:
{
  nixpkgs.config.rocmSupport = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu.opencl.enable = true;

  # services.xserver = {
  #   enable = true;
  #   videoDrivers = [ "amdgpu" ];
  # };
}
