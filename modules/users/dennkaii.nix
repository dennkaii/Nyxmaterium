{self, ...}: let
  inherit (self.lib) mkDotsModule;
  username = "dennkaii";
in {
  dandelion.users.dennkaii = {
    pkgs,
    config,
    lib,
    ...
  }: {
    empyrean = {
      data.users = [username];
      # must configure secrets at some point oml
    };

    users.users.${username} = {
      description = "dennkaii user";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "multimedia" "dialout"];
      initialPassword = "123456";

      # only declare common packages here
      # others: hosts/<hostname>/user-configuration.nix
      # if you declare something here that isn't common to literally every host I
      # will personally show up under your bed whoever and wherever you are
      packages = [
        pkgs.btop
        pkgs.git
        pkgs.bat
        pkgs.delta
      ];
    };

    hjem.users.${username} = {
      enable = true;
      user = username;
      directory = config.users.users.${username}.home;
      clobberFiles = lib.mkForce true;

      impure = {
        enable = true;
        dotsDir = "${self.paths.dots}";
        dotsDirImpure = "/home/${username}/nixos/dots";
        parseAttrs = [
          config.hjem.users.${username}.xdg.config.files
          config.hjem.users.${username}.xdg.state.files
        ];
      };
    };
    dandelion.dots.cli = {
      "git/config" = "/git/config";
    };

    dandelion.dots.mango = mkDotsModule username {
      "mango/config.conf" = "/mango/config.conf";
      "mango/binds.conf" = "/mango/binds.conf";
    };
  };
}
