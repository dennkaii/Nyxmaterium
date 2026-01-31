{
  programs.nvf.settings.vim.languages = {
    enableFormat = true;
    enableTreesitter = true;
    nix.enable = true;
    rust = {
      enable = true;
      # crates.enable = true;
    };
    html.enable = true;
    python.enable = true;
    markdown.enable = true;
    bash.enable = true;
    lua.enable = true;
    go = {
      enable = true;
      dap.enable = true;
      lsp.enable = true;
      treesitter.enable = true;
    };
    sql = {
      enable = false;
      lsp.enable = false;
      treesitter.enable = true;
      format.enable = true;
    };
    qml = {
      enable = true;
      lsp.enable = true;
      treesitter.enable = true;
      format.enable = true;
    };
  };
}
