{pkgs, ...}: {
  programs.nvf.settings.vim.diagnostics = {
    enable = true;
    config = {
      virtual_lines = false;
      virtual_text = false;
    };
  };
}
