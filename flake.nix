{
  description = "A very basic flake";

  outputs = inputs:
  inputs.flake-parts.lib.mkFlake{inherit inputs;}{
  systems = ["x86_64-linux"];
    imports = [./hosts];
    perSystem = {
      config,
      pkgs,
      ...
    }:{
      #deshells go here
      formatter = pkgs.alejandra;
    };
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    niri-flake = {
       url="github:Sodiboo/niri-flake";
     };
  nvf.url = "github:notashelf/nvf";
  systems.url = "github:nix-systems/default-linux";
flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
     flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
     zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
