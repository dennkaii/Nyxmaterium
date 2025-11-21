{
  pkgs,
  config,
  lib,
  ...
}: let
  mangoconfDir = "/home/dennkaii/Projects/Nyxmaterium/home/programs/wayland/mango/config";
in {
  imports = [
    ./zoxide.nix
    ./nushell.nix
    ./starship.nix
    ./atuin.nix
    ./carapace.nix
  ];
  home.packages = [
    pkgs.fzf
    pkgs.fish
  ];
}
