{pkgs, ...}: {
  wrappers.nyxt = {
    basePackage = pkgs.nyxt;
  };
}
