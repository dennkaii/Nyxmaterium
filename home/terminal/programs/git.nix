{pkgs, ...}: {
  home.packages = [pkgs.gh];
  programs.git = {
    enable = true;
    userName = "dennkaii";
    userEmail = "70287696+dennkaii@users.noreply.github.com";
  };

  programs.lazygit = {
    enable = true;
  };
}
