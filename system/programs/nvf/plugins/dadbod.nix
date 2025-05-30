{
  pkgs,
  lib,
  ...
}: let
  vim-dadbod = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dadbod";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-dadbod";
      rev = "9f0ca8bcef704659820a95c3bbd2c262583a66a1";
      sha256 = "sha256-7wlMfOpt5lcKuZPfiY+3hbaSN0YkjpbtF4L2ko/pfI4=";
    };
  };
  vim-dadbod-completion = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dadbod-completion";
    src = pkgs.fetchFromGitHub {
      owner = "kristijanhusak";
      repo = "vim-dadbod-completion";
      rev = "a8dac0b3cf6132c80dc9b18bef36d4cf7a9e1fe6";
      sha256 = "sha256-F+bCrgrRyNtgafwMSjkEBVj3LCBlxFZKajMF0K+x8D8=";
    };
  };
  vim-dadbod-ui = pkgs.vimUtils.buildVimPlugin {
    name = "vim-dadbod-ui";
    src = pkgs.fetchFromGitHub {
      owner = "kristijanhusak";
      repo = "vim-dadbod-ui";
      rev = "685e75b34ee0e12f92ec4507ea8bb7f1aaa936e5";
      sha256 = "sha256-8kxncJDpRMXhQFkctReo/bx8sSHdzzolgFgJPe2oKMc=";
    };
  };
in {
  programs.nvf.settings.vim.extraPlugins = {
    vim-dadbod = {
      package = vim-dadbod;
    };
    vim-dadbod-ui = {
      package = vim-dadbod-ui;
    };
    vim-dadbod-completion = {
      package = vim-dadbod-completion;
    };
  };
  # programs.nvf.settings.vim.autocmds = [
  #   {
  #     desc = "dadboot-autocompletion";
  #     # command = "lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })";
  #     callback = lib.generators.mkLuaInline ''
  #       function()
  #         require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
  #       end
  #     '';
  #     event = "";
  #     pattern = [
  #       "sql"
  #       "mysql"
  #       "plsql"
  #     ];
  #   }
  # ];
}
