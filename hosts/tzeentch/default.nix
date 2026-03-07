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

  # services.logind.settings.Login = {
  #   lidSwitch = "hibernate";
  #   lidSwitchExternalPower = "hibernate";
  #   lidSwitchDocked = "ignore";
  # };
  # services.logind.settings.Login.LidSwitch = "suspend-then-hibernate";
  # Hibernate on power button pressed
  # services.logind.settings.Login.PowerKey = "hibernate";
  # services.logind.settings.Login.PowerKeyLongPress = "poweroff";
  # systemd.sleep.extraConfig = ''
  #   HibernateDelaySec=30m
  #   SuspendState=mem
  # '';
  #
  services.asusd.enable = true;
  services.supergfxd.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
        enable_thresholds = true;
        start_threshold = 0;
        stop_threshold = 80;
        platform_profile = "quiet";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
}
