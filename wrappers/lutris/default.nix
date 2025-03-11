{
  pkgs,
  config,
  ...
}: {
  wrappers.lutris = {
    basePackage = pkgs.lutris;
    extraPackages = with pkgs; [
      wineWowPackages.full
      winetricks
      wine64Packages.full
    ];
    # extraPackages = with pkgs; [
    #   xorg.libXcursor
    #   xorg.libXi
    #   xorg.libXinerama
    #   xorg.libXScrnSaver
    #   gamemode
    #   winetricks
    #   wineWowPackages.full
    #   wine64Packages.full
    #   jansson
    #   libpng
    #   libpulseaudio
    #   libvorbis
    #   stdenv.cc.cc.lib
    #   libkrb5
    #   keyutils
    # ];
  };
}
