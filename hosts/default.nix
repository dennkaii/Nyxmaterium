{
  self,
  inputs,
  config,
  ...
}: {
  flake.nixosConfigurations = let
    specialArgs = {inherit inputs self;};
    inherit (inputs.nixpkgs.lib) nixosSystem;
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
        ];
    };
  };
}
