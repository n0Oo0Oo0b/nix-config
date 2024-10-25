{lib, ...}: {
  services.kanata = {
    enable = true;
    keyboards.dareu = {
      config = let
        src = [
          "f1"
          "f2"
          "caps"
          "v"
          "kp0"
          "comp"
        ];
        common = ''
          comp rmet
          caps (multi f24 (tap-hold-press 500 200 esc lctl))
          f1 (layer-switch default)
          f2 (layer-switch games)
        '';
      in ''
        (defsrc ${lib.strings.concatStringsSep " " src})

        (deflayermap (default)
          ${common}
        )
        (deflayermap (games)
          ${common}
          v spc
          kp0 (multi (layer-switch default) M-1)
        )
      '';
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
