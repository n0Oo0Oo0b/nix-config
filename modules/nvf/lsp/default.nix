{
  vim.languages = {
    enableLSP = true;
    enableTreesitter = true;

    clang.enable = true;
    clang.cHeader = true;
    lua.enable = true;
    markdown.enable = true;
    nix.enable = true;
    nu.enable = true;
    python.enable = true;
    rust.enable = true;
    wgsl.enable = true;
  };

  vim.lsp = {
    enable = true;

    # Opts
    formatOnSave = true;

    # Other plugins
    lspSignature.enable = true;
    lsplines.enable = true;
    otter-nvim.enable = true;
  };
}
