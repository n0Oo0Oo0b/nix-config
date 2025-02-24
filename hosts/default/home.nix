{
  self,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../home/discord.nix
    ../../home/firefox.nix
    ../../home/godot.nix
    ../../home/git.nix
    ../../home/i3
    ../../home/terminal.nix
    ../../home/vscode.nix
    ../../home/zed.nix
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.username = "danielgu";
  home.homeDirectory = "/home/danielgu";

  # i18n.inputMethod.fcitx5.catppuccin.apply = true;

  # NOTE: Check home-manager release notes before changing
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.cudaSupport = true;
  nixpkgs.overlays = [
    (final: prev: {
      # Requires an old version of Nvidia something or something
      opencv = prev.opencv.override {enableCuda = false;};
    })
  ];

  home.packages = with pkgs; [
    # General use
    obsidian
    libreoffice
    slack
    zotero
    anki-bin
    inputs.zen-browser.packages.${stdenv.system}.default

    # Commandline
    porsmo
    ripgrep
    du-dust
    mprocs
    self.packages.${stdenv.system}.neovim

    # Misc
    ffmpeg
    alejandra
    davinci-resolve
    pulseaudio
    (blender.override {cudaSupport = true;})
    osu-lazer-bin
    prismlauncher
    rquickshare
  ];

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  gtk = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.icon.enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk2.extraConfig = "gtk-application-prefer-dark-theme=true";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      input-overlay
    ];
  };

  # Dotfiles
  home.file = {
    ".ideavimrc".text = ''
      imap <C-Space> <Right><Esc>
      vmap <C-Space> <Esc>

      nmap H ^
      nmap L $

      imap <C-l> <Right><BS>

      nmap g<CR> :action ShowIntentionActions<CR>
      :command! R action Run
      :command! RC action RunClass
      :command! Fmt action ShowReformatFileDialog

      set ideajoin
    '';

    ".background-image".source = ../../extras/wallpapers/nixos-nord.jpg;
  };

  xdg.configFile = {
    "zellij/config.kdl".source = ../../extras/zellij.kdl;
    "zoomus.conf".source = ../../extras/zoomus.conf;
    "ytmdesktop/style.css".source = ../../extras/ytmdesktop-ctp.css;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
