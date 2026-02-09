{
  systems = ["x86_64-linux"];

  perSystem = {pkgs, ...}: {
    packages = {
      nyxt-4 = pkgs.callPackage ./nyxt/package.nix {};
    };
  };
}
