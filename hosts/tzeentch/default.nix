{pkgs,self,...}: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
}
