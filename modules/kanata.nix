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
          caps (multi f24 (tap-hold-press 300 100 esc lctl))
          lctl (multi ctl (layer-while-held ctl))
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

        (deflayermap (ctl)
          f1 (layer-switch default)
          f2 (layer-switch games)
        )
      '';
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
