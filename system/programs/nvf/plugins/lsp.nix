{pkgs, ...}: {
  programs.nvf.settings.vim = {
    lsp = {
      enable = true;

      formatOnSave = true;
      lightbulb.enable = false;
      # lspsaga.enable = true;
      trouble.enable = false;
      lspSignature.enable = true;
      # lsplines.enable = true; removed from nvf
      lspconfig.enable = true;
      nvim-docs-view.enable = true;
      lspconfig.sources.qmlls = ''
        lspconfig.qmlls.setup {
          capabilities = capabilities,
          cmd = {"${pkgs.kdePackages.qtdeclarative}/bin/qmlls", "-E"}
        }
      '';
    };
  };
}
