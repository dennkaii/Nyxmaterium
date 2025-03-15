{
  pkgs,
  inputs,
  ...
}: {
  networking.hostId = "2bf9a036";

  nixpkgs.config.allowUnfree = true;

  # programs.nvf.enable = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  services.asusd.enable = true;
  services.supergfxd.enable = true;
  services.tlp.enable = true;

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
  ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];

  environment.sessionVariables = {NIXOS_OZONE_WL = "1";};

  programs.git = {
    enable = true;
    config = {
      init = {
        defaultBranch = "master";
      };
      user = {
        name = "dennkaii";
        email = "githubdennkaii.q3i49@simplelogin.com";
      };
    };
  };

  programs.niri.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  environment.systemPackages = with pkgs; [
    fuzzel
    kitty
    ghostty
    firefox
    tidal-hifi
    vesktop
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  #DO NOT DELETE DUMB ASS
  system.stateVersion = "24.11";
}
