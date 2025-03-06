{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    impermanence.url = "github:nix-community/impermanence";
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

  outputs = { self, nixpkgs, impermanence,nvf ,... }@inputs: {

nixosConfigurations.default = nixpkgs.lib.nixosSystem {
  specialArgs = {inherit inputs;};

  modules = [
    ./configuration.nix
    nvf.nixosModules.default 
    inputs.impermanence.nixosModules.impermanence
    inputs.niri-flake.nixosModules.niri
    ];  
};

  };
}
