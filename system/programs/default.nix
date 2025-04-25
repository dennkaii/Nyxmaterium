{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./nvf.nix
    ./direnv.nix
    ./xdg.nix
  ];
}
