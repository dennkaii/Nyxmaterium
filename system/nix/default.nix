{...}: {
  imports = [
    ./nh.nix
  ];
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
    "electron-36.9.5"
  ];
}
