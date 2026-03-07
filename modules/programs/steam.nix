{
  dandelion.modules.steam = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs:
          with pkgs; [
            mangohud
            keyutils
            gamemode
            libkrb5
            libpng
            libpulseaudio
            libvorbis
          ];
      };
    };
    gamescope = {
      enable = true;
      # capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };
}
