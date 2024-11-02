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
          "lctl"
          "rctl"
        ];
        common = ''
          comp rmet
          caps (multi f24 (tap-hold-press 0 200 esc lctl))
          lctl (multi ctl (layer-while-held ctrl))
          rctl (multi ctl (layer-while-held ctrl))
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

        (deflayermap (ctrl)
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
