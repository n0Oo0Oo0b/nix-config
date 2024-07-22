{
  config,
  pkgs,
  ...
}: {
  hardware.graphics.enable = true;
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    # screenSection = ''
    #   Option         "metamodes" "DP-2: 1920x1080_75 +0+0 {rotation=left, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-4: 2560x1440_144 +1080+240 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    #   Option         "AllowIndirectGLXProtocol" "off"
    #   Option         "TripleBuffer" "on"
    # '';
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
