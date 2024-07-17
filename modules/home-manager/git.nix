{...}: {
  programs.git = {
    enable = true;
    userName = "Daniel Gu";
    userEmail = "bobthebuilder10492@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
