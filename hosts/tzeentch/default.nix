{
  pkgs,
  lib,
  self,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
  ];
  environment.variables.FLAKE = lib.mkForce "/home/dennkaii/projects/Nyxmaterium/";

  networking.hostName = "tzeentch";

  services.asusd.enable = true;
  services.supergfxd.enable = true;
  services.tlp.enable = true;
}
