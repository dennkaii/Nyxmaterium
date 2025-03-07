{
  self,
  inputs,
  ...
}:
{
flake.nixosConfigurations = let
   specialArgs = {inherit inputs self;};
    inherit (inputs.nixpkgs.lib) nixosSystem;
    mod = "${self}/system";
    inherit (import mod) laptop;
in {
  tzeentch = nixosSystem {
    inherit specialArgs;
    modules =
     [
      ./tzeentch
      ../system/core
      ../system/core/boot.nix
    ];
  };
};
}
