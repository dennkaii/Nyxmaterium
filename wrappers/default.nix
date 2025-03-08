{
  lib,
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (inputs.wrapper-manager.lib.build {
      inherit pkgs;
      modules = [];
    })
  ];
}
