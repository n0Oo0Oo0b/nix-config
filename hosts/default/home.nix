{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ../../home/vscode.nix
    ../../home/git.nix
    ../../home/i3
    ../../home/nvim
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home.username = "danielgu";
  home.homeDirectory = "/home/danielgu";

  # i18n.inputMethod.fcitx5.catppuccin.apply = true;

  # NOTE:: Check home-manager release notes before changing
  home.stateVersion = "23.11";

  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    # General use
    firefox
    obsidian
    youtube-music
    libreoffice
    slack
    (pkgs.discord.override {withTTS = true;})
    zoom-us
    zotero
    anki-bin

    # Dev
    python311
    # neovide
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.clion
    zed-editor

    # Commandline
    porsmo
    ripgrep
    du-dust
    mprocs

    # Misc
    ffmpeg
    pandoc
    texliveFull
    alejandra
    pulseaudio
  ];

  gtk = {
    enable = true;
    catppuccin.enable = true;
    catppuccin.icon.enable = true;

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    gtk2.extraConfig = "gtk-application-prefer-dark-theme=true";
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 12;
    };
    settings = {
      disable_ligatures = "cursor";
    };
  };

  programs.btop.enable = true;
  programs.starship.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.gitui.enable = true;
  programs.sioyek.enable = true;
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
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

    ".bashrc".text = ''
      eval "$(starship init bash)"
    '';

    ".background-image".source = ../../extras/wallpapers/nixos-nord.jpg;
  };

  xdg.configFile = {
    "nvim" = {
      source = ../../extras/nvim;
      recursive = true;
    };

    "zellij/config.kdl".source = ../../extras/zellij.kdl;

    "zoomus.conf".source = ../../extras/zoomus.conf;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    "ls" = "eza";
    "cat" = "bat";

    "glo" = "git log --oneline";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
