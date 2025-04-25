{
  self,
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations = let
    specialArgs = {inherit inputs self;};
    inherit (inputs.nixpkgs.lib) nixosSystem;
    homeImports = import "${self}/home/profiles";
    mod = "${self}/system";
    inherit (import mod) laptop;
  in {
    tzeentch = nixosSystem {
      inherit specialArgs;
      modules =
        config.laptop
        ++ [
          ./tzeentch
          ../wrappers/default.nix
          inputs.lix-module.nixosModules.default
          {
            home-manager = {
              users.dennkaii.imports = homeImports."dennkaii@tzeentch";
              extraSpecialArgs = specialArgs;
              backupFileExtension = "backup";
            };
          }
        ];
    };
  };
}
