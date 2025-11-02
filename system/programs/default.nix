{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./nvf.nix
    ./tmux.nix
    ./direnv.nix
    ./mango.nix
    ./xdg.nix
    ./games/default.nix
  ];
}
