{
  vim = {
    # autocomplete.nvim-cmp.mappings = {};
    # comments.comment-nvim.mappings = {};
    # git.gitsigns.mappings = {};
    keymaps = let
      set = mode: key: action: { inherit mode key action; };
      set-lua = mode: key: action: { inherit mode key action; lua = true; };
    in [
      # Misc
      (set "" "H" "^")
      (set "" "L" "$")
      (set "n" "<Esc>" "<Cmd>nohlsearch<CR>")
      (set "i" "<C-Space>" "<Right><Esc>")
      (set "v" "<C-Space>" "<Esc>")
      (set "n" "<C-Space>" "<Cmd>w<CR>")
      (set "i" "<C-l>" "<Del>")

      # Diagnostics
      (set-lua "n" "[d" "vim.diagnostic.goto_prev")
      (set-lua "n" "]d" "vim.diagnostic.goto_next")
      (set-lua "n" "<leader>e" "vim.diagnostic.open_float")
      (set-lua "n" "<leader>q" "vim.diagnostic.setloclist")
    ];
  };

}
