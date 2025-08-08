util: with util; {
  default = {
    ro = "(layer-while-held nav)";
    # nlck = "(layer-switch chords)";
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
      # Fn
    }
    // (genAttrs digits (d: "f${d}"))
    // {
      "0" = "f10";
      min = "f11";
      eql = "f12";
    };

  # chords = {
  #   ro = "(layer-while-held nav)";
  #   nlck = "(layer-switch default)";
  #   caps = cap-ctrl;
  #   esc = "grv";
  # } // (genAttrs chordkeys (l: "(chord chords ${escapeSpecial l})"));
}
