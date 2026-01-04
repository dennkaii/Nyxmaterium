{
  programs.nvf.settings.vim = {
    filetree.neo-tree = {
      enable = true;
      setupOpts = {
        git_status_async = true;
        window = {
          mapping_options = {nowait = false;};
          mappings = {
            "<space>" = "none";
            "l" = "open_drop";
            # "h" = {"@1" = "navigate_up";};
            "z" = "none";
            "zc" = "close_node";
            "zC" = "close_all_nodes";
            "v" = "open_vsplit";
            "h" = "open_split";
            "a" = "add";
            "d" = "delete";
            "c" = "copy";
            "m" = "move";
            "/" = "fuzzy_finder";
          };
        };
      };
    };
    maps = {
      normal = {
        "<leader>e".action = ":Neotree left toggle reveal<CR>";
      };
    };
  };
}
