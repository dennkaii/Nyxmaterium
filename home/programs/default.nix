{...}: {
  imports = [
    ./gtk.nix
    ./qt.nix

    ./wayland/niri.nix
    ./sherlock/default.nix
  ];
}
