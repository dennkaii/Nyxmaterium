{...}: {
  programs.nvf.settings.vim = {
    navigation.harpoon = {
      enable = true;
      mappings = {
        listMarks = "<leader>h";
        markFile = "<C-a>";
        file1 = "<C-1>";
        file2 = "<C-2>";
        file3 = "<C-3>";
        file4 = "<C-4>";
      };
    };
  };
}
