{
  pkgs,
  config,
  lib,
  ...
}: {
  boot = {
    kernelModules = ["kvm-amd"];
    kernelParams = lib.mkAfter [
      "nvidia-drm.modeset=1"
      "mem_sleep_default=s2idle"
      "no_console_suspend"
      "amd_pstate=active"
      "nvme.noacpi=1"
    ];

    blacklistedKernelModules = ["ucsi_acpi"];
    kernelPackages = pkgs.linuxPackages_xanmod;
    extraModulePackages = [];
    supportedFilesystems.ntfs = true;

    initrd = {
      availableKernelModules = ["uas" "nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod" "sdhci_pci"];
      kernelModules = ["amdgpu" "asus-wmi" "asus-nb-wmi"];
      systemd = {
        enable = true;
        managerEnvironment = {
          SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK = "1";
        };
      };
    };

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        efiSupport = true;
        devices = ["nodev"];
      };
    };

    zfs = {
      devNodes = "/dev/disk/by-partuuid";
      requestEncryptionCredentials = true;
    };
  };
}
