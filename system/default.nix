{
  config,
  lib,
  ...
}: let
  cfg = config.laptop;
  inherit (lib) mkOption types;
in {
  options.laptop = mkOption {
    type = with types; listOf path;
    default = [];
    description = ''       
      Paths that will be added to laptop'';
  };
  config = {
    laptop = [
      ./core
      ./core/boot.nix
      ./programs
    ];
  };
}
