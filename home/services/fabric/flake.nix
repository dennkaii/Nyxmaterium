{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fabric.url = "github:Fabric-Development/fabric";
    devenv.url = "github:cachix/devenv";
  };
  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        inputs.devenv.flakeModule # To import a flake module
      ];
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        devenv,
        ...
      }: rec {
        devenv.shells = {
          default = {
            enterShell = ''
              hello
            '';

            languages = {
              python = {
                enable = true;
                uv = {
                  enable = true;
                };
              };
            };
            packages = with pkgs; [
              ruff # Linter
              basedpyright # Language server

              # Required for Devshell
              gtk3
              gtk-layer-shell
              cairo
              gobject-introspection
              libdbusmenu-gtk3
              gdk-pixbuf
              gnome-bluetooth
              cinnamon-desktop
              (python3.withPackages (
                ps:
                  with ps; [
                    setuptools
                    wheel
                    build
                    python-fabric
                  ]
              ))
              (python3.withPackages (ps:
                with ps; [
                  pygobject3
                  psutil
                  pulsectl
                  inputs.fabric.packages.${pkgs.system}.default
                ]))
            ];
          };
        };
      };
    };
}
