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
      "no_console_suspend"
      "amd_pstate=active"
      "nvme.noacpi=1"
    ];
    extraModprobeConfig = ''
      options nvidia NVreg_TemporaryFilePath=/var/tmp
    '';

    blacklistedKernelModules = ["ucsi_acpi"];
    kernelPackages = pkgs.linuxPackages_xanmod;
    extraModulePackages = [];
    supportedFilesystems.ntfs = true;

    initrd = {
      availableKernelModules = ["uas" "nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod" "sdhci_pci"];
      kernelModules = ["amdgpu" "asus-wmi" "asus-nb-wmi" "nvidia_uvm" "nvidia_modeset" "nvidia_drm" "nvidia"]; # all nvidia lines are testing
      systemd = {
        enable = true;
        # managerEnvironment = {
        #   SYSTEMD_BYPASS_HIBERNATION_MEMORY_CHECK = "1";
        # };
        #                       nvidia
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
