{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../home/vscode.nix
    ../../home/git.nix
    ../../home/i3
  ];

  home.username = "danielgu";
  home.homeDirectory = "/home/danielgu";

  # NOTE:: Check home-manager release notes before changing
  home.stateVersion = "23.11";

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
    sioyek

    # Dev
    python311
    # neovide
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.clion
    zed-editor

    # Commandline
    zellij
    porsmo
    ripgrep
    eza
    du-dust
    bat
    mprocs
    gitui

    # Misc
    ffmpeg
    font-manager
    pandoc
    texliveFull
    alejandra
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-Dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    cursorTheme = {
      name = "Adwaita";
      size = 10;
    };

    gtk2 = {
      extraConfig = "gtk-application-prefer-dark-theme=true";
      configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono Nerd Font";
      size = 12;
    };
  };

  programs.neovim = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    settings = {};
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
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

    "${config.xdg.configHome}/nvim" = {
      source = ../../extras/nvim;
      recursive = true;
    };

    "${config.xdg.configHome}/zellij/config.kdl".source = ../../extras/zellij.kdl;

    "${config.xdg.configHome}/zoomus.conf".source = ../../extras/zoomus.conf;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
