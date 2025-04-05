{ ... }: {
  imports = [
    ../../home/common
  ];

  home.username = "pansternoob";
  home.homeDirectory = "/home/pansternoob";

  home.packages = [];

  # Dotfiles
  home.file = {};
}
