{pkgs, ...}: {
  services = {
    flatpak.enable = true;

    mysql = {
      enable = true;
      package = pkgs.mysql84; # for the sake of the guide im following, might change later to mariadb?
    };
  };
}
