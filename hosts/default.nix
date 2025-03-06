{
  self,
  inputs,
  ...
}:
let
 specialArgs = {inherit inputs self;};
inherit (inputs.nixpkgs.lib) nixosSystem;
in {
  tzeentch = nixosSystem {
    inherit specialArgs;
    modules = [
      ./tzeentch
    ];
  };
}
