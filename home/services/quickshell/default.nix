{
  pkgs,
  inputs,
  ...
}: let
  programs = with pkgs; [
    ddcutil
    brightnessctl
    # app2unit
    # cava
    networkmanager
    lm_sensors
    fish
    # aubio
    # pipewire
    glibc
    libgcc
    grim
    swappy
    libqalculate
  ];
in {
  home.packages = [inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default]; #++ programs;
}
