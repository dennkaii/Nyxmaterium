{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.nushell = {
    enable = true;
    configFile.source = ./nushell/config.nu;
    envFile.source = ./nushell/env.nu;

    shellAliases = {
      sysupdate = "sudo nixos-rebuild switch --flake ~/.nixConfig/#Aethyr";

      "gs" = "git status";
      "gb" = "git branch";
      "gch" = "git checkout";
      "gc" = "git commit";
      "ga" = "git add";
    };
  };

  programs = {
    atuin.enable = true;
    broot.enable = true;
    carapace.enable = true;
    eza.enable = true;
  };
  programs.atuin.enableNushellIntegration = true;
  programs.eza.enableNushellIntegration = true;
  programs.broot.enableNushellIntegration = true;
}
