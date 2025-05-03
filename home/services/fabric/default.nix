{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.fabric.packages.${pkgs.system}.default
  ];
}
