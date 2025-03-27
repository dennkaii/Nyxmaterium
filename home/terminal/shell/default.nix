{pkgs, ...}: {
  imports = [
    ./zoxide.nix
    ./nushell.nix
    ./starship.nix
  ];
  home.packages = [
    pkgs.fzf
    pkgs.fish
  ];
}
