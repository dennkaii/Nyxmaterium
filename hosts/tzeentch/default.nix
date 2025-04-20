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
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
