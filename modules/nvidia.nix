{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    monitorSection = ''
      ModelName    "AOC 27V5"
      HorizSync     85.0 - 85.0
      VertRefresh   48.0 - 75.0
    '';
    screenSection = ''
      Monitor      "Monitor[0]"
      Option       "metamodes" "DP-2: 1920x1080_75 +0+0 {rotation=left, ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-4: 2560x1440_144 +1080+240 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
      Option       "AllowIndirectGLXProtocol" "off"
      Option       "TripleBuffer" "on"
    '';
    exportConfiguration = true;
  };
}
