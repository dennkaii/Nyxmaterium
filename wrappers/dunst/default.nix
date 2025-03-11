{
  pkgs,
  inputs,
  lib,
  ...
}: {
  wrappers.dunst = {
    basePackage = pkgs.dunst;
    flags = [
      "-config"
      ./dunstrc
    ];
  };
}
