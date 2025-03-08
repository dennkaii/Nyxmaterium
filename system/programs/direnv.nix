{
  pkgs,
  self,
  config,
  ...
}: {
  users.epackages = with pkgs; [
    alejandra
    deadnix
    statix
  ];
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
