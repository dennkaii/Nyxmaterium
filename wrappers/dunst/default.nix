{
  pkgs,
  inputs,
  lib,
  ...
}: {
  wrappers.dunst = {
    basePackage = pkgs.dunst;
    prependFlags = [
      "-conf"
      ./dunstrc
    ];
  };
}
