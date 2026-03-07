{
  dandelion.modules.nvida = {pkgs, ...}: {
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
        #dedicated
        nvidiaBusId = "PCI:100:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # sync.enable = true;
      };
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = true;

      nvidiaSettings = true;
    };
  };
}
