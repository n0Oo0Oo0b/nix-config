{
  vim.languages = {
    enableLSP = true;

    clang.enable = true;
    markdown.enable = true;
    nix.enable = true;
    nu.enable = true;
    python.enable = true;
    rust.enable = true;
  };
  vim.lsp = {
    enable = true;

    # Opts
    formatOnSave = true;

    # Other plugins
    lspSignature.enable = true;
    lsplines.enable = true;
    lspsaga.enable = true;
    otter-nvim.enable = true;
  };
}
