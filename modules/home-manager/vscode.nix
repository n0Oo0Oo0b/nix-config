{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim

      bbenoist.nix

      james-yu.latex-workshop
      ms-python.python
      ms-python.vscode-pylance

      ms-vsliveshare.vsliveshare
      github.codespaces
    ];
    userSettings = {
      "files.autoSave" = "off";
      "editor.lineNumbers" = "relative";
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "explorer.confirmDelete" = false;

      # Make nvim work
      "extensions.experimental.affinity" = {
        "asvetliakov.vscode-neovim" = 1;
      };
    };
  };
}
