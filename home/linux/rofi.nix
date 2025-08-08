{ pkgs, ... }:
{

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    plugins = [ pkgs.rofi-calc ];
    theme = {
      "*".width = "600px";
      "*".font = "monospace 12";
      window.height = "720px";
    };
  };
  catppuccin.rofi.flavor = "macchiato";
}
