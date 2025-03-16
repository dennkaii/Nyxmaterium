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
      ./hardware/nvidia.nix
      ./hardware/amd.nix
      ./services/greetd.nix
      ./services/komga.nix
      ./programs/home-manager.nix
      ./programs/games.nix
    ];
  };
}
