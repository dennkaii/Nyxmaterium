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
        ./devenv/default.nix
        ./nyxt/default.nix
        {
          wrappers.zen = {
            basePackage = inputs.zen-browser.packages.${pkgs.system}.default;
          };

          wrappers.jj = {
            basePackage = inputs.jj.packages.${pkgs.system}.default;
          };
          wrappers.deezer-enhanced = {
            basePackage = inputs.deezer-enhanced.packages.${pkgs.system}.default;
            flags = [
              "--ozone-platform-hint=wayland"
            ];
          };
        }
      ];
    })
  ];
}
