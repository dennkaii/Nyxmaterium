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
      ./nix/default.nix
      ./programs/default.nix
      ./hardware/nvidia.nix
      ./hardware/amd.nix
      ./hardware/dialpad.nix
      ./services/greetd.nix
      #      ./services/swww.nix
      ./programs/thunderbird.nix
      ./services/komga.nix
      ./programs/home-manager.nix
      ./programs/games.nix
      ./services/sql.nix
      ./services/podman.nix
      ./services/virtual-machines.nix
    ];
  };
}
