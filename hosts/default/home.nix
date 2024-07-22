{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/home-manager/vscode.nix
    ../../modules/home-manager/git.nix
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
    # blender
    zoom-us
    zotero
    anki-bin
    obs-studio
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

  programs.neovim = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {};
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

    "${config.xdg.configHome}/nvim" = {
      source = ../../extras/nvim;
      recursive = true;
    };

    "${config.xdg.configHome}/zellij/config.kdl".source = ../../extras/zellij.kdl;

    ".bashrc".text = ''
      eval "$(starship init bash)"
    '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
