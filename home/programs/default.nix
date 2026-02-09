{pkgs, ...}: {
  imports = [
    ./gtk.nix
    ./qt.nix

    ./browsers/zen.nix
    # ./browsers/nyxt.nix
    ./wayland/default.nix
    # ./sherlock/default.nix
  ];
  services.udiskie = {
    enable = true;
    settings = {
      # workaround for
      # https://github.com/nix-community/home-manager/issues/632
      program_options = {
        # replace with your favorite file manager
        file_manager = "${pkgs.nemo-with-extensions}/bin/nemo";
      };
    };
  };
}
