{
  I2s = {
    command = ''
      function()
        vim.bo.expandtab = true
        vim.bo.tabstop = 2
      end
    '';
    desc = "Indent to 2 spaces";
  };
  I4s = {
    command = ''
      function()
        vim.bo.expandtab = true
        vim.bo.tabstop = 4
      end
    '';
    desc = "Indent to 4 spaces";
  };
}
