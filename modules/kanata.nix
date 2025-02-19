{lib, ...}: let
  inherit (lib.attrsets) nameValuePair mapAttrsToList foldlAttrs mapAttrs';
  inherit (lib.strings) concatStringSep stringToCharacters;

  digits = stringToCharacters "1234567890";
  letters = stringToCharacters "abcdefghijklmnopqrstuvwxyz";

  defsrc = digits ++ letters ++ ["caps" "esc" "ro" "nlck" "bspc" "min" "eql"];

  # Vars
  mouse-speed = 1;
  scroll-rate = 50;
  # Aliases
  movemouse = direction: "(movemouse-${direction} 1 ${mouse-speed})";
  mousewheel = direction: "mwheel-${direction} ${scroll-rate} 120";
  cap-ctrl = "(multi f24 (tap-hold-press 0 200 esc lctl))";

  # Layers
  layers = {
    default = {
      ro = "(layer-while-held nav)";
      nlck = "(layer-switch chords)";
      caps = cap-ctrl;
      esc = "grv";
    };

    nav =
      {
        # Arrow
        w = "up";
        a = "left";
        s = "down";
        d = "right";
        # Mouse
        u = "mlft";
        o = "mrgt";
        i = movemouse "up";
        j = movemouse "left";
        k = movemouse "down";
        l = movemouse "right";
        y = mousewheel "up";
        h = mousewheel "down";
        # Media
        z = "prev";
        x = "pp";
        c = "next";
        r = "volu";
        f = "vold";
        # Other
        esc = "esc";
        caps = "esc";
        bspc = "caps";
      }
      // (
        # Fn
        digits
        # |> map (d: nameValuePair d "f${d}")
        # |> listToAttrs
      )
      // {
        "0" = "f10";
        min = "f11";
        eql = "f12";
      };
  };
  # # Config building
  # sections = { inherit defsrc; } // (
  #   layers |> mapAttrs' (name: entries: nameValuePair
  #     "deflayermap (${name})"
  #     (entries |> foldlAttrs (acc: n: v: acc ++ [n v]) [])
  #   )
  # )
in {
  services.kanata = {
    enable = true;
    keyboards.drunkdeer = {
      # devices = [
      #   "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-event-kbd"
      #   "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-if01-event-kbd"
      # ];
      port = 60001;
      config = (
        sections
        # |> mapAttrsToList (name: entries: "(${name} ${entries |> concatStringSep " "})")
        # |> concatStringSep "\n"
      );
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
