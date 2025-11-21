{
  config,
  lib,
  pkgs,
  ...
}: let
  mangoconfDir = "/home/dennkaii/Projects/Nyxmaterium/home/programs/wayland/mango/config";
in {
  home.activation.symlink-mango = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p ${config.home.homeDirectory}/.config
    rm -rf ${config.home.homeDirectory}/.config/mango
    ln -sfn ${mangoconfDir} ${config.home.homeDirectory}/.config/mango
  '';
}
