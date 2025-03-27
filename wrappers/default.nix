{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  config.users.epackages = [
    (inputs.wrapper-manager.lib.build {
      inherit pkgs;
      modules = [
        ./dunst/default.nix
        ./lutris/default.nix
        {
          wrappers.zen = {
            basePackage = inputs.zen-browser.packages.${pkgs.system}.default;
          };
        }
      ];
    })
  ];
}
