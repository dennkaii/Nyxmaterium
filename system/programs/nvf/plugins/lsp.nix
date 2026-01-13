{pkgs, ...}: {
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;

      formatOnSave = true;
      lightbulb.enable = false;
      # lspsaga.enable = true;
      trouble.enable = false;
      # lsplines.enable = true; removed from nvf
      nvim-docs-view.enable = true;
    };
  };
}
