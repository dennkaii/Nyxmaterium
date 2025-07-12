{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./nvf.nix
    ./tmux.nix
    ./direnv.nix
    ./xdg.nix
    ./games/default.nix
  ];
}
