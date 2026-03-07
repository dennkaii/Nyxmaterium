{
  dandelion.modules.empyrean-data = {
    lib,
    config,
    ...
  }: let
    inherit (lib) mkOption;
    inherit (lib.types) listOf str;
  in {
    options.empyrean.data = {
      users = mkOption {
        type = listOf str;
        default = [];
        description = "list of users (duh)";
      };
    };
  };
}
#basically stolen from my rexie config, zaphkiel-data.nix for more info about this :)

