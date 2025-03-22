{
  pkgs,
  config,
  lib,
  ...
}: {
  services.komga = {
    enable = true;
    user = "dennkaii";
    settings.server.port = 25600;
  };
}
