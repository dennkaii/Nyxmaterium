{nixpkgs, ...}: {
  dandelion.modules.nix = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    nix = {
      registry.nixpkgs.flake = nixpkgs;
      channel.enable = false;
      settings = {
        allow-import-from-derivation = false;
        experimental-features = ["nix-command" "flakes"];
        auto-optimise-store = true;
        trusted-users = ["root" "@wheel"];
        substituters = [
          "https://nix-community.cachix.org"
          "https://vicinae.cachix.org"
          "https://nixpkgs-python.cachix.org" # for devevn with python
          "https://devenv.cachix.org" #for devenv to work properly
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
          "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
          "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
        ];
      };
      gc = {
        persistent = true;
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
  };
}
