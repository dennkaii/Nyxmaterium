{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.brightnessctl
  ];
}
