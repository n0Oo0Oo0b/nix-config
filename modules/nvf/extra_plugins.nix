{pkgs, ...}: {
  vim.extraPlugins = with pkgs.vimPlugins; {
    telescope-ui = {
      package = telescope-ui-select-nvim;
    };
  };
}
