{ lib, pkgs, ... }: let
  configFile = import ./config_file.nix { inherit lib pkgs; };
in {
  config = lib.mkMerge [
    # NixOS module
    # (lib.optionalAttrs pkgs.stdenv.isLinux {
    #   services.kanata = {
    #     enable = true;
    #     keyboards.drunkdeer = {
    #       # devices = [
    #       #   "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-event-kbd"
    #       #   "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-if01-event-kbd"
    #       # ];
    #       port = 60001;
    #       inherit configFile;
    #     };
    #   };
    # })

    # darwin launchd agent
    {
      services.karabiner-elements.enable = true;

      launchd.agents.kanata = {
        command = ''
          kanata --cfg ${configFile}
        '';
        path = [pkgs.kanata];
      };
    }
  ];
}
