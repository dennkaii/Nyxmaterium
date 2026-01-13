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
# ALWAYS remember <c-\><c-\n> to get into escpae mode inside a terminal :)

