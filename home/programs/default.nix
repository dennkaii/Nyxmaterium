{...}: {
  imports = [
    ./gtk.nix
    ./qt.nix

    ./browsers/zen.nix
    ./browsers/nyxt.nix
    ./wayland/default.nix
    ./sherlock/default.nix
  ];
}
