{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.gh];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "dennkaii";
        email = "70287696+dennkaii@users.noreply.github.com";
      };
    };
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    extraConfig.gpg.format = "ssh";
  };

  programs.lazygit = {
    enable = true;
  };
}
