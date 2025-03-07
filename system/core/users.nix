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
    main = mkOption {
      type = with types; str;
      description = ''
        Main user
      '';
    };
    host = mkOption {
      type = with types; str;
      description = ''
        Host name
      '';
    };

    groups = mkOption {
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
      extraGroups = ["wheel" "networkmanager"]++cfg.groups;
      };
    mutableUsers = false;
    };
  };
}
