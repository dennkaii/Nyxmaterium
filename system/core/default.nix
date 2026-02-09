{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkDefault;
in {
  imports = [
    ./boot.nix
    ./users.nix
    ./fonts.nix
  ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    # saves space
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "ro_RO.UTF-8/UTF-8"
    ];
  };

  documentation.dev.enable = true;

  time.timeZone = "America/Santo_Domingo";
  services.ntp.enable = true;
  time.hardwareClockInLocalTime = true;

  system.stateVersion = mkDefault "24.11";
}
