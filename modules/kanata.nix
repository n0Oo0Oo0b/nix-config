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
        (defsrc f1 f2 caps v)

        (deflayermap (base-layer)
          ${common}
        )
        (deflayermap (strata)
          ${common}
          v spc
        )
      '';

      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
