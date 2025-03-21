{
  pkgs,
  config,
  ...
}: {
  boot = {
    kernelModules = ["kvm-amd"];
    kernelParams = ["nvidia-drm.modeset=1"];
    blacklistedKernelModules = ["ucsi_acpi" "noveau"];
    kernelPackages = pkgs.linuxPackages_xanmod;
    extraModulePackages = [];
    supportedFilesystems.ntfs = true;

    initrd = {
      availableKernelModules = ["uas" "nvme" "xhci_pci" "thunderbolt" "usb_storage" "usbhid" "sd_mod" "sdhci_pci"];
      kernelModules = ["amdgpu" "asus-wmi" "asus-nb-wmi"];
      systemd.enable = true;
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
