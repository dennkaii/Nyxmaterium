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

    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:Sodiboo/niri-flake";
    };
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms.url = "github:AvengeMedia/DankMaterialShell";
    asus-dialpad-driver = {
      url = "github:asus-linux-drivers/asus-dialpad-driver";
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
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sherlock = {
      url = "github:Skxxtz/sherlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    superfile = {
      url = "github:yorukot/superfile";
    };
    matlab-nix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "gitlab:doronbehar/nix-matlab";
    };
    nyxt = {
      url = "github:Occhima/nix-conf";
    };
    vicinae.url = "github:vicinaehq/vicinae";
  };
}
