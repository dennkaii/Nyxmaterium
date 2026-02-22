{
  dandelion.modules.services = {
    services.fwupd.enable = true;
    services.thermald.enbale = true;

    # handles battery in theory xd
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
  };
}
