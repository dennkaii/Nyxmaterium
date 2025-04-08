{...}: {
  programs.nvf.settings.vim = {
    terminal.toggleterm = {
      enable = true;
      lazygit = {
        enable = true;
        mappings = {
          open = "<leader>tl";
        };
      };

      mappings = {
        open = "<leader>to";
      };
    };
  };
}
