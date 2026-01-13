{
  programs.nvf.settings.vim.notes.neorg = {
    enable = true;
    treesitter.enable = true;
    setupOpts.load = {
      "core.defaults".enable = true;
      "core.concealer".config.icon_preset = "diamond";
      "core.dirman".config = {
        workspaces = {
          notes = "/home/dennkaii/Documents/notes";
        };
      };
    };
  };
}
