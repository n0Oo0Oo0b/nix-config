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

    # "${config.xdg.configHome}/kitty/kitty.conf".source = ../../extras/kitty.conf;

    "${config.xdg.configHome}/zellij/config.kdl".source = ../../extras/zellij.kdl;

    "${config.xdg.configHome}/zoomus.conf".source = ../../extras/zoomus.conf;

    ".screenlayout/monitor.sh".text = ''
      #!/bin/sh
      LEFT='DP-2'
      RIGHT='DP-3'
      xrandr --output $RIGHT --primary --right-of $LEFT --mode 2560x1440 --rate 144 --output $LEFT --mode 1920x1080 --rate 75 --rotate left
      xrandr --output $RIGHT --pos 1080x240
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
