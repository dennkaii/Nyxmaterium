{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [
  ];
  home = {
    username = "dennkaii";
    homeDirectory = "/home/dennkaii";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "devdoc"];
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
