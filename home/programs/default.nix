{...}: {
  imports = [
    ./gtk.nix
    ./qt.nix

    ./wayland/default.nix
    ./sherlock/default.nix
  ];
}
