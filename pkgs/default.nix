{
  systems = ["x86_64-linux"];

  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    packages = {
      #pinned to a working nixpkgs rev in the meantime
      nyxt-4 = inputs'.nyxt-rev.legacyPackages.callPackage ./nyxt/package.nix {};
    };
  };
}
