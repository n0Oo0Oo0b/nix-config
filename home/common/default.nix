{ self, pkgs, ... }: {
  imports = [
    ./git.nix
    ./nixpkgs.nix
    ./terminal.nix
    ./vscode.nix
    ./zed.nix
  ];

  # Basic packages
  home.packages = with pkgs; [
    obsidian
    zotero
    anki-bin
    drawio

    ffmpeg
    alejandra

    ripgrep
    du-dust
    mprocs
    self.packages.${stdenv.system}.neovim
    self.packages.${stdenv.system}.rebuild

    osu-lazer-bin
    prismlauncher
  ];

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
  };

  xdg.configFile = {
    "zellij/config.kdl".source = ../extras/zellij.kdl;
    "zoomus.conf".source = ../extras/zoomus.conf;
    "ytmdesktop/style.css".source = ../extras/ytmdesktop-ctp.css;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
