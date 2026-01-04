{pkgs, ...}: {
  home.packages = [pkgs.gh];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "dennkaii";
        email = "70287696+dennkaii@users.noreply.github.com";
      };
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
