{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.fabric.packages.${pkgs.stdenv.hostPlatform.system}.run-widget
    playerctl
  ];
}
