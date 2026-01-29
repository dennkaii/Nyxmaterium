{
  pkgs,
  inputs,
  lib,
  ...
}: let
  #Must move to a separete file inside system/nix/overlay
  stableOverlay = final: prev: {
    stable = import inputs.stable-nix {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
in {
  #must be set for ZFS
  networking.hostId = "2bf9a036";

  #this was gpted
  systemd.services."systemd-rfkill".enable = false;
  systemd.services."systemd-rfkill@".enable = false;
  systemd.sockets."systemd-rfkill".enable = false;

  systemd.services."systemd-rfkill".wantedBy = lib.mkForce [];
  systemd.sockets."systemd-rfkill".wantedBy = lib.mkForce [];

  #kills wifi for suspend and restores kys mediatek
  environment.etc."systemd/system-sleep/mt7925-reload" = {
    text = ''
      #!/bin/sh
      MODPROBE=/run/current-system/sw/sbin/modprobe
      case "$1" in
        pre)
          echo "[mt7925-reload] Unloading Wi-Fi modules..." | systemd-cat -t mt7925-reload
           $MODPROBE -r mt7925e mt792x_lib mt76_connac_lib mt76
          ;;
        post)
          echo "[mt7925-reload] Reloading Wi-Fi modules..." | systemd-cat -t mt7925-reload
          $MODPROBE mt7925e
          ;;
      esac
    '';
    mode = "0755";
  };
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x14c3", ATTR{device}=="0x7925", ATTR{power/control}="on"
  '';

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      stableOverlay
      inputs.matlab-nix.overlay
    ];
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://vicinae.cachix.org"
    "https://nixpkgs-python.cachix.org" # for devevn with python
    "https://devenv.cachix.org" #for devenv to work properly
  ];

  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "nixpkgs-python.cachix.org-1:hxjI7pFxTyuTHn2NkvWCrAUcNZLNS3ZAvfYNuYifcEU="
    "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  programs.niri.enable = true;

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default
  services.blueman.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = with pkgs; [
    fuzzel
    quickemu
    kitty

    # stremio
    google-chrome
    btop
    vesktop
    dwarfs
    nemo-with-extensions
    nautilus
    fuse3
    fuse-overlayfs
    exiftool
    bubblewrap
    readest
    gnome-software
    vscodium
    qemu
    protonup-qt
    protontricks
    # (stable.rstudioWrapper.override {
    #   packages = with stable.rPackages; [
    #     # xts
    #     # Rcpp
    #     # rmarkdown
    #     # tidyverse
    #     # skimr
    #     # htmltools
    #     # markdown
    #     # knitr
    #     # reshape
    #     # glmc
    #     # sjmisc
    #     # # pubh  # Este paquete estaba comentado en tu código original
    #     # ggplot2
    #     # forcats
    #     # modelr
    #     # broom
    #     # sjPlot
    #     # olsrr
    #     # car
    #     # lme4
    #     # Matrix
    #   ];
    # })

    ## NO WORKY FML
    # stable.davinci-resolve
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
