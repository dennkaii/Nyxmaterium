{pkgs, ...}: {
  home.packages = [pkgs.gh];
  programs.git = {
    enable = true;
    userName = "dennkaii";
    userEmail = "githubdennkaii.q3i49@simplelogin.com";
  };

  programs.lazygit = {
    enable = true;
  };
}
