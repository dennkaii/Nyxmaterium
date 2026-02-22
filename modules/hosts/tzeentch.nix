## Main computer asus p16 laptop
{
  self,
  lib,
  ...
}: {
  dandelion.hosts.tzeentch = {
    imports = [
      #empty so far
    ];
    networking.hostName = "tzeentch";
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "24.11";
    time.timeZone = "America/Santo_Domingo";
    #for ZFS
    networking.hostId = "2bf9a036";

    services.openssh = {
      enable = true;
      startWhenNeeded = lib.mkForce true; #gota ask why this was false tho
      openFirewall = lib.mkForce false;
    };

    networking.networkmanager.enable = true;

    ## fileSystem ZFS
    fileSystems."/" = {
      device = "zroot/root";
      fsType = "zfs";
      neededForBoot = true;
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    fileSystems."/nix" = {
      device = "zroot/nix";
      fsType = "zfs";
    };

    fileSystems."/tmp" = {
      device = "zroot/tmp";
      fsType = "zfs";
    };

    fileSystems."/cache" = {
      device = "zroot/cache";
      fsType = "zfs";
    };

    fileSystems."/persist" = {
      device = "zroot/persist";
      fsType = "zfs";
      neededForBoot = true;
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/e830898e-8eec-4c79-8832-7aa3f8ed5a6c";}
    ];
  };
}
