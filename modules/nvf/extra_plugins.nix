{pkgs, ...}: {
  vim.extraPlugins = with pkgs.vimPlugins; {
    telescope-ui = {
      package = telescope-ui-select-nvim;
      setup = "require('telescope').load_extension('ui-select')";
      after = ["telescope"];
    };
  };
}
