util: let
  lexical = [];
  alternative = {
    "abt" = "about";
    # Custom
    "dco" = "discord";
    "gih" = "github";
    "lhst" = "localhost";
  };
in alternative // util.genAttrs lexical (w: w)
