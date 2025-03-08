{
  pkgs,
  inputs,
  ...
}: {
  wrappers.zen = {
    basePackage = inputs.zen-browser.packages.${pkgs.system}.default;
  };
}
