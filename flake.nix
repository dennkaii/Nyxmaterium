{
  description = "A very basic flake";

  # outputs = inputs:
  #   inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  #     systems = ["x86_64-linux"];
  #     imports = [
  #       ./hosts
  #       ./pkgs
  #       ./system
  #     ];
  #     perSystem = {
  #       config,
  #       pkgs,
  #       ...
  #     }: {
  #       #deshells go here
  #       devShells = {
  #         default = pkgs.mkShell {
  #           nativeBuildInputs = [
  #             inputs.nixpkgs.legacyPackages.x86_64-linux.python3
  #           ];
  #           packages = [
  #             pkgs.alejandra
  #             pkgs.git
  #             pkgs.nodePackages.prettier
  #           ];
  #           name = "dots";
  #           DIRENV_LOG_FORMAT = "";
  #         };
  #       };
  #       formatter = pkgs.alejandra;
  #     };
  #   };
  #
  outputs = {...} @ inputs: let
    dandelion = import ./dandelion.nix inputs;
    inherit (dandelion) importModules recursiveImport;
  in
    importModules [
      (recursiveImport ./modules) #dandelion modules
      (recursiveImport ./flake) #helpers and so on
    ];

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    asus-dialpad-driver = {
      url = "github:asus-linux-drivers/asus-dialpad-driver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    tidal-luna = {
      url = "github:Inrixia/TidaLuna";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    superfile = {
      url = "github:yorukot/superfile";
    };
    vicinae.url = "github:vicinaehq/vicinae";
  };
}
