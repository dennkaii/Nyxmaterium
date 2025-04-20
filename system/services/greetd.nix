{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) getExe concatStringsSep;
in {
  services.greetd = let
    defaultSession = {
      user = "greeter";
      command = concatStringsSep " " [
        (getExe pkgs.greetd.tuigreet)
        "--time"
        "--remember"
        "--remember-user-session"
        "asterisks"
      ];
    };

    session = {
      command = "${pkgs.niri}/bin/niri-session";
      user = "dennkaii";
    };
  in {
    enable = true;
    settings = {
      terminal.vt = 1;
      default_session = defaultSession;
      initial_session = session;
    };
  };
}
