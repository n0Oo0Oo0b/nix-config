{ lib, ... }: let
  inherit (lib.attrsets) nameValuePair mapAttrsToList mapAttrs' attrByPath genAttrs;
  inherit (lib.strings) stringToCharacters concatStrings;
  inherit (builtins) concatStringsSep listToAttrs;

  # Vars
  mouse-speed = 1;
  scroll-rate = 50;
  chord-timeout = 35;
  digits = stringToCharacters "1234567890";
  letters = stringToCharacters "abcdefghijklmnopqrstuvwxyz";
  chordkeys = digits ++ letters ++ [" "];
  specialChars = {
    " " = "spc";
    "!" = "S-1";
    "@" = "S-2";
    "#" = "S-3";
    "$" = "S-4";
    "%" = "S-5";
    "^" = "S-6";
    "&" = "S-7";
    "*" = "S-8";
    "(" = "S-9";
    ")" = "S-0";
    "~" = "S-grv";
  } // (genAttrs digits (d: "Digit${d}"));

  # Aliases
  escapeSpecial = key: attrByPath [key] key specialChars;
  movemouse = direction: "(movemouse-${direction} 1 ${toString mouse-speed})";
  mousewheel = direction: "(mwheel-${direction} ${toString scroll-rate} 120)";
  interspaces = text: text |> stringToCharacters |> map escapeSpecial |> concatStringsSep " ";
  macro = text: "(macro ${interspaces text})";
  cap-ctrl = "(multi f24 (tap-hold-press 0 200 esc lctl))";

  defsrc = digits ++ letters ++ ["caps" "esc" "ro" "nlck" "bspc" "min" "eql"];

  # Layers
  layers = {
    default = {
      ro = "(layer-while-held nav)";
      nlck = "(layer-switch chords)";
      caps = cap-ctrl;
      esc = "grv";
    };

    nav = {
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
      # Fn
    } // (genAttrs digits (d: "f${d}")) // {
      "0" = "f10";
      min = "f11";
      eql = "f12";
    };

    chords = {
      ro = "(layer-while-held nav)";
      nlck = "(layer-switch default)";
      caps = cap-ctrl;
      esc = "grv";
    } // (genAttrs chordkeys (l: "(chord words ${escapeSpecial l})"));
  };

  chords.words = {
    "gih" = "github";
    "dco" = "discord";
    "lst" = "last";
    "rout" = "192.168.100.1";
    "lhst" = "localhost";
  } // (genAttrs [
    "an" "and" "of" "on" "it" "is" "in" "the" "this"
  ] (w: w));

  # Config building
  sections = {
    inherit defsrc;
  } // (
    layers |> mapAttrs' (name: entries: nameValuePair
      "deflayermap (${name})"
      (entries |> mapAttrsToList (n: v: "${escapeSpecial n} ${v}")))
  ) // (
    chords |> mapAttrs' (name: entries: nameValuePair
      "defchords ${name} ${toString chord-timeout}"
      ((entries |> mapAttrsToList (n: v: "(${interspaces n}) ${macro v}"))
      ++ (chordkeys |> map escapeSpecial |> map (k: "(${k}) ${k}"))))
  );

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
        |> mapAttrsToList (name: entries:
          "(${name} ${entries |> map toString |> concatStringsSep " "})")
        |> concatStringsSep "\n"
      );
      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
