{
  ...
}:
{
  hardware.graphics.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
  };

  # hardware.amdgpu = {
  #   initrd.enable = true;
  #   amdvlk.enable = true;
  # };
}
