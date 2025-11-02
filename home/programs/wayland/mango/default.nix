{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  mangoconfDir = "/home/dennkaii/Projects/Nyxtmaterium/home/programs/wayland/mango/config";
in {
  #stolen from: https://github.com/mrashieee/rashix/tree/dcc1eaf53b9126ec8f62bf2994699664b9d53812/home/config/mango
  imports = [
    inputs.mango.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
  };
}
