{ lib, pkgs, ... }:
let
  configFile = import ./config_file.nix { inherit lib pkgs; };
in
{
  services.kanata = {
    enable = true;
    keyboards.drunkdeer = {
      devices = [
        "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-event-kbd"
        "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-if01-event-kbd"
      ];
      port = 60001;
      inherit configFile;
    };
  };
}
# {
#   services.karabiner-elements.enable = true;
#
#   launchd.agents.kanata = {
#     command = ''
#       sudo kanata \
#         --cfg ${configFile} \
#         --port 60001
#     '';
#     path = [pkgs.kanata];
#   };
# }
