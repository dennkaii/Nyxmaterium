{pkgs, ...}: {
  dconf = {
    enable = true;

    #virtualization settigns
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };
}
