{
  pkgs,
  lib,
  config,
  ...
}: let
 cfg = config.users;
  inherit (lib) mkOption types;
in {
   options.users = {
    egroups = mkOption {
      type = with types; listOf str;
      default = [];
      description = ''
        Extra groups the main user will be apart of.
      '';
    };
  };
  config = {
  users.users = {
    root = {
      isSystemUser = true;
      group = "root";
      initialPassword = "123456";
    };
    dennkaii = {
      uid = 1000;
      isNormalUser = true;
      group = "users";
      initialPassword = "123456";
      extraGroups = ["wheel" "networkmanager"]++cfg.egroups;
      };
    };
    users.mutableUsers = false;
  };
}
