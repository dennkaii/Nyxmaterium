{
  pkgs,
  inputs,
  ...
}: let
  wall = inputs.wallpkgs.wallpapers.misc.unorganized-12.path;
in {
  systemd.services = {
    swww = {
      enable = true;
      wantedBy = ["niri.service"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        Restart = "on-failure";
        RestartSec = 1;
      };
    };
    defualt_wall = {
      enable = true;
      wantedBy = ["swww.service"];
      wants = ["swww.service"];
      after = ["swww.service"];
      serviceConfig = {
        ExecStart = ''${pkgs.swww}/bin/swww img "${wall}" --transition-type random'';
        Restart = "on-failure";
        Type = "oneshot";
      };
    };
  };
}
