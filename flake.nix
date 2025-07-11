{
  description = "A very basic flake";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [
        ./hosts
        ./system
      ];
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        #deshells go here
        devShells = {
          default = pkgs.mkShell {
            nativeBuildInputs = [
              inputs.nixpkgs.legacyPackages.x86_64-linux.python3
            ];
            packages = [
              pkgs.alejandra
              pkgs.git
              pkgs.nodePackages.prettier
            ];
            name = "dots";
            DIRENV_LOG_FORMAT = "";
          };
        };
        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stable-nix.url = "github:NixOS/nixpkgs/nixos-25.05";

    niri = {
      url = "github:Sodiboo/niri-flake";
    };
    asus-dialpad-driver = {
      url = "github:asus-linux-drivers/asus-dialpad-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deezer-enhanced = {
      url = "github:dennkaii/deezer-enhanced";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    systems.url = "github:nix-systems/default-linux";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tidal-luna = {
      url = "github:Inrixia/TidaLuna";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wrapper-manager = {
      url = "github:viperML/wrapper-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    gauntlet = {
      url = "github:dennkaii/gauntlet";
      inputs.systems.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
