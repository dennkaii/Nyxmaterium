{
  pkgs,
  config,
  lib,
  ...
}: {
  services.komga = {
    enable = true;
  };
}
