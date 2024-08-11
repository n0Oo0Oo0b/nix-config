[
  {
    event = [ "TextYankPost" ];
    command = ''
      function() vim.highlight.on_yank() end
    '';
    group = "kickstart-highlight-yank";
    desc = "Highlight on yank";
  }
]
