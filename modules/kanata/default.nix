{ lib, ... }: let
  # Builtins
  inherit (lib.attrsets) nameValuePair mapAttrsToList mapAttrs' attrByPath genAttrs;
  inherit (lib.strings) stringToCharacters concatStrings;
  inherit (builtins) concatStringsSep listToAttrs;

  # Utils for imports
  util = rec {
    inherit genAttrs;

    # Vars
    mouse-speed = 1;
    scroll-rate = 50;
    chord-timeout = 35;
    digits = stringToCharacters "1234567890";
    letters = stringToCharacters "abcdefghijklmnopqrstuvwxyz";
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

    # Utility functions
    escapeSpecial = key: attrByPath [key] key specialChars;
    interspaces = text: text |> stringToCharacters |> map escapeSpecial |> concatStringsSep " ";

    # Kanata aliases
    movemouse = direction: "(movemouse-${direction} 1 ${toString mouse-speed})";
    mousewheel = direction: "(mwheel-${direction} ${toString scroll-rate} 120)";
    macro = text: "(macro ${interspaces text})";
    cap-ctrl = "(multi f24 (tap-hold-press 0 200 esc lctl))";

    chordkeys = digits ++ letters ++ [" "];
    defsrc = digits ++ letters ++ ["caps" "esc" "ro" "nlck" "bspc" "min" "eql"];
  };

  chords = (chordkeys |> map escapeSpecial |> map (k: "(${k}) ${k}"))
    ++ (import ./chords.nix util) |> mapAttrsToList (n: v: "(${util.interspaces n}) (${util.macro v})");

  layers = (import ./layers.nix util) |> mapAttrs' (name: entries: nameValuePair
    "deflayermap (${name})"
    (entries |> mapAttrsToList (n: v: "${escapeSpecial n} ${v}")))

  # Config building
  sections = {
    inherit (util) defsrc;
    "defchords chords ${toString chord-timeout}" = chords;
  } // layers;

in {
  imports = [
    ./layers.nix
    ./chords.nix
  ];

  services.kanata = {
    enable = true;
    keyboards.drunkdeer = {
      # devices = [
      #   "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-event-kbd"
      #   "/dev/input/by-id/usb-Drunkdeer_Drunkdeer_G60_ANSI_RYMicro-if01-event-kbd"
      # ];
      port = 60001;
      config = with util; (
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
