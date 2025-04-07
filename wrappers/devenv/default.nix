{pkgs, ...}: {
  wrappers.devenv = {
    basePackage = pkgs.devenv;
  };
}
