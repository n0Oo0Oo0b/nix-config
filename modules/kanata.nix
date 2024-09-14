{...}: {
  services.kanata = {
    enable = true;
    keyboards.dareu = {
      config = let
        common = ''
          caps (tap-hold 100 100 esc lctl)
          f1 (layer-switch base-layer)
          f2 (layer-switch strata)
        '';
      in ''
        (defsrc f1 f2 caps c)

        (deflayermap (base-layer)
          ${common}
        )
        (deflayermap (strata)
          ${common}
          c spc
        )
      '';

      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
