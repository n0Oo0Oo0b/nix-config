{ pkgs, ... }:
{

  programs.rofi = {
    enable = true;
    terminal = "kitty";
    plugins = [ pkgs.rofi-calc ];
    theme = {
      "*".font = "monospace 12";
      window.height = "720px";
      window.border-radius = "10px";
    };
  };
  catppuccin.rofi.flavor = "macchiato";
}
