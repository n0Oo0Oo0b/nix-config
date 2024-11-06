{lib, ...}: {
  services.kanata = {
    enable = true;
    keyboards.drunkdeer = {
      devices = [
        "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-event-kbd"
        "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-if01-event-kbd"
      ];
      port = 60001;
      config = ''
        (defsrc
          caps esc
          ro nlck bspc
          w a s d
          i j k l u o y h
          r f
          1 2 3 4 5 6 7 8 9 0 min eql
        )

        (defvar
          ;; Values
          mouse-speed 1
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
          ro (layer-while-held nav)
          nlck (layer-switch nav)
          caps (multi f24 (tap-hold-press 0 200 esc lctl))
          esc grv
        )

        (deflayermap (nav)
          ;; Arrow keys
          w up a left s down d right
          ;; Mouse
          u mlft o mrgt
          i @msu j @msl k @msd l @msr
          y @mwu h @mwd
          ;; fn
          1 f1 2 f2 3 f3 4 f4 5 f5 6 f6
          7 f7 8 f8 9 f9 0 f10 min f11 eql f12
          ;; Other
          esc esc
          bspc caps
          r volu f vold
          ;; Layers
          ret (layer-switch default)
          spc (layer-switch default)
        )
      '';
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
