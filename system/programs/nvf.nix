{inputs, ...}: {
  imports = [
    inputs.nvf.nixosModules.default
    ./nvf/plugins/default.nix
    ./nvf/settings.nix
  ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
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
