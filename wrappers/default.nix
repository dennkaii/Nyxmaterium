{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: let
  wrappers = inputs.wrapper-manager.lib {
    inherit pkgs;
    modules = [
      ./dunst/default.nix
      ./lutris/default.nix
      ./devenv/default.nix
      # ./nyxt/default.nix
      ./blender/default.nix
      {
        wrappers.zen = {
          basePackage = inputs.zen-browser.packages.${pkgs.system}.default;
        };

        # wrappers.jj = {
        # basePackage = inputs.jj.packages.${pkgs.system}.default;
        # };
        wrappers.deezer-enhanced = {
          basePackage = inputs.deezer-enhanced.packages.${pkgs.system}.default;
          prependFlags = [
            "--ozone-platform-hint=wayland"
          ];
        };
        # wrappers.quteBrowser = {
        #   basePackage = pkgs.qutebrowser;
        # };
        wrappers.tidal-luna = {
          basePackage = inputs.tidal-luna.packages.${pkgs.system}.default;
        };
        # wrappers.davinci = {
        #   basePackage = pkgs.davinci-resolve;
        # };
      }
    ];
  };
in {
  config.environment.systemPackages = [
    wrappers.config.build.toplevel
  ];
}
