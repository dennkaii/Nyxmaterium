{
  pkgs,
  lib,
  config,
  ...
}: {
  nixpkgs.config.nvidia.acceptLicense = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [
    "nvidia"
  ];

  hardware.nvidia = {
    prime = {
      amdgpuBusId = "PCI:101:0:0";
      nvidiaBusId = "PCI:100:0:0";
      # offload = {
      #   enable = true;
      #   enableOffloadCmd = true;
      # };
      sync.enable = true;
    };
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
  };
  #https://discourse.nixos.org/t/black-screen-after-suspend-hibernate-with-nvidia/54341/6
  systemd.services."systemd-suspend" = {
    serviceConfig = {
      Environment = ''"SYSTEMD_SLEEP_FREEZE_USER_SESSIONS=false"'';
    };
  };

  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
  #   version = "565.77";
  #   sha256_64bit = "sha256-CnqnQsRrzzTXZpgkAtF7PbH9s7wbiTRNcM0SPByzFHw=";
  #   sha256_aarch64 = "sha256-LSAYUnhfnK3rcuPe1dixOwAujSof19kNOfdRHE7bToE=";
  #   openSha256 = "sha256-Fxo0t61KQDs71YA8u7arY+503wkAc1foaa51vi2Pl5I=";
  #   settingsSha256 = "sha256-VUetj3LlOSz/LB+DDfMCN34uA4bNTTpjDrb6C6Iwukk=";
  #   persistencedSha256 = "sha256-wnDjC099D8d9NJSp9D0CbsL+vfHXyJFYYgU3CwcqKww=";
  # };
}
