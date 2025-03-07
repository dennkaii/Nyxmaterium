{
  inputs,
  pkgs,
  config,
  ...
}:{
imports = [
  inputs.nvf.nixosModules.default
];
  programs.nvf = {
    enable = true;
    settings = {
        vim = {
        languages = {
    enableLSP = true;
    enableFormat = true;
    enableTreesitter = true;
    nix.enable = true;
    rust = {
      enable = true;
      # crates.enable = true;
    };
    html.enable = true;
    python.enable = true;
    markdown.enable = true;
    bash.enable = true;
    lua.enable = true;
  };
         package = pkgs.neovim-unwrapped;
      vimAlias = false;
      viAlias = false;

      autoIndent = true;
      autocomplete.nvim-cmp.enable = true;
      autopairs.nvim-autopairs.enable = true;
      enableEditorconfig = true;
      preventJunkFiles = true;
      enableLuaLoader = true;
      useSystemClipboard = true;
      spellcheck = {
        enable = true;
        languages = ["en"];
      };
      hideSearchHighlight = true;
      searchCase = "smart";
      splitRight = true;
    
          theme = {
            enable = true;
            name = "oxocarbon";
            style = "dark";
          };

          comments = {
            comment-nvim.enable = true;
          };

          binds = {
            # whichKey.enable = true;
            cheatsheet.enable = true;
          };
        };
      };
  };
}
