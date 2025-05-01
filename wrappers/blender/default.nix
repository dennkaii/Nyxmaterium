{pkgs, ...}: {
  wrappers.blender = {
    basePackage = pkgs.blender;
  };
}
