{...}: {
  services.kanata = {
    enable = true;
    keyboards.dareu = {
      config = let
        common = ''
          caps (tap-hold 100 100 esc lctl)
          f1 (layer-switch default)
          f2 (layer-switch games)
        '';
      in ''
        (defsrc f1 f2 caps v)

        (deflayermap (default)
          ${common}
        )
        (deflayermap (games)
          ${common}
          v spc
          ;; keypad_0 (multi (layer-switch default) M-1)
        )
      '';

      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
