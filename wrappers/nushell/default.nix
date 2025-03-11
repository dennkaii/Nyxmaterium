{
  pkgs,
  config,
  ...
}: {
  wrappers.nushell = {
    basePackage = pkgs.nushell;
    pathAdd = [pkgs.starship pkgs.carapace pkgs.atuin pkgs.zoxide];
    flags = ["--env-config" ./env.nu "--config" ./config.nu];
  };
}
