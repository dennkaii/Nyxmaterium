{
  pkgs,
  inputs,
  ...
}: {
  #must be set for ZFS
  networking.hostId = "2bf9a036";

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://nixpkgs-python.cachix.org" # for devevn with python
    "https://devenv.cachix.org" #for devenv to work properly
  ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  programs.niri.enable = true;

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  environment.systemPackages = with pkgs; [
    fuzzel
    quickemu
    bitwarden-cli
    kitty
    arduino-ide
    google-chrome
    netflix
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
