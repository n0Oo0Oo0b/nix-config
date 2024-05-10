{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    screenSection = ''
      Option       "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
      Option       "AllowIndirectGLXProtocol" "off"
      Option       "TripleBuffer" "on"
    '';
    extraConfig = ''
      Section "Screen"
          Identifier     "Screen0"
          Device         "Device0"
          Monitor        "Monitor0"
          DefaultDepth    24
          Option         "Stereo" "0"
          Option         "nvidiaXineramaInfoOrder" "DFP-5"
          Option         "metamodes" "DP-2: 1920x1080_75 +0+0 {rotation=left, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-4: 2560x1440_144 +1080+240 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
          Option         "SLI" "Off"
          Option         "MultiGPU" "Off"
          Option         "BaseMosaic" "off"
          SubSection     "Display"
              Depth       24
          EndSubSection
      EndSection
    '';
  };
}
