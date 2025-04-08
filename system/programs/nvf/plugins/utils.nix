{...}: {
  programs.nvf.settings.vim = {
    # binds.whichKey.enable = true;
    notify.nvim-notify.enable = true;
    ui = {
      illuminate.enable = true;
      noice = {
        enable = true;
        setupOpts = {
          presets.bottom_search = false;
          views.popupmenu.scrollbar = false;
        };
      };

      breadcrumbs = {
        enable = true;

        navbuddy = {
          enable = true;
        };
      };

      fastaction = {
        enable = true;
        setupOpts = {
          dismiss_keys = ["q" "<esc>"];
          keys = "abcdefghijklmnoprstuvwxyz";
          popup = {
            title = "Select:";
            relative = "cursor";
          };
        };
      };
    };

    visuals = {
      indent-blankline.enable = true;
      highlight-undo.enable = true;
      nvim-web-devicons.enable = true;
    };

    maps.normal."<leader>al" = {
      desc = "Open Navbuddy";
      action = "<cmd>Navbuddy<cr>";
    };
  };

  # programs.nvf.settings.vim.lazy.plugins = {
  #   dressing = {
  #     package = "dressing-nvim";
  #     setupOpts = {
  #       select.enabled = false;
  #     };
  #   };
  # };
}
