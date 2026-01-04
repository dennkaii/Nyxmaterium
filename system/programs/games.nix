{
  pkgs,
  lib,
  config,
  ...
}: {
  programs = {
    gamescope = {
      enable = true;
      # capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };

    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            keyutils
            gamemode
            libkrb5
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
          ];
      };
      # gamescopeSession.enable = true;
      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];
    };
  };
}
