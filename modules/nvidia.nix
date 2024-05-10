{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    monitorSection = ''
      VendorName   "Unknown"
      ModelName    "AOC 27V5"
      HorizSync     85.0 - 85.0
      VertRefresh   48.0 - 75.0
      Option       "DPMS"
    '';
    deviceSection = ''
      VendorName   "NVIDIA Corporation"
      BoardName    "NVIDIA GeForce RTX 3080"
    '';
    screenSection = ''
      Monitor      "Monitor[0]"
      Option       "metamodes" "DP-2: 1920x1080_75 +0+0 {rotation=left, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-4: 2560x1440_144 +1080+240 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      Option       "AllowIndirectGLXProtocol" "off"
      Option       "TripleBuffer" "on"
      DefaultDepth    24
      Option         "Stereo" "0"
      Option         "nvidiaXineramaInfoOrder" "DFP-5"
      Option         "SLI" "Off"
      Option         "MultiGPU" "Off"
      Option         "BaseMosaic" "off"
      SubSection     "Display"
          Depth       24
      EndSubSection
    '';
    exportConfiguration = true;
  };
}
