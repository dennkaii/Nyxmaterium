{
  programs.nvf.settings.vim = {
    keymaps = [
      {
        key = "<C-h>";
        mode = "n";
        action = "<C-w>h";
      }
      {
        key = "<C-l>";
        mode = "n";
        action = "<C-w>l";
      }
      {
        key = "<C-j>";
        mode = "n";
        action = "<C-w>j";
      }
      {
        key = "<C-k>";
        mode = "n";
        action = "<C-w>k";
      }
      {
        key = "<C-s>";
        mode = "n";
        action = "<cmd>w<CR>";
        desc = "save file";
      }
      {
        desc = "Prevus buffer";
        key = "H";

        mode = "n";
        action = ":bn<CR>";
        noremap = false;
      }

      {
        desc = "Next buffer";
        key = "L";

        mode = "n";
        action = ":bp<CR>";
        noremap = false;
      }

      {
        desc = "Write all";
        key = "<C-s>";

        mode = ["n" "i"];
        action = "<Esc>:wall<CR>";
      }
    ];
  };
}
