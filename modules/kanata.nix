{lib, ...}: {
  services.kanata = {
    enable = true;
    keyboards.drunkdeer = {
      config = ''
          (defsrc
            caps comp
            i j k l
            w a s d q e r f
          )

          (defvar
            ;; Values
            mouse-speed 5
            scroll-rate 50
          )
          (defalias
            msu (movemouse-up 1 $mouse-speed)
            msd (movemouse-down 1 $mouse-speed)
            msl (movemouse-left 1 $mouse-speed)
            msr (movemouse-right 1 $mouse-speed)
            mwu (mwheel-up $scroll-rate 120)
            mwd (mwheel-down $scroll-rate 120)
        )

          (deflayermap (default)
            comp (layer-switch nav)
            caps (multi f24 (tap-hold-press 0 200 esc lctl))
          )

          (deflayermap (nav)
            ;; Arrow keys
            i up
            j left
            k down
            l right
            ;; Mouse
            q mlft
            e mrgt
            w @msu a @msl s @msd d @msr
            r @mwu f @mwd

            ret (layer-switch default)
          )
      '';
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
