{
  pkgs,
  config,
  ...
}: {
  home.packages = [pkgs.dconf];
  dconf.enable = true; #wiki says gtk may not work without it
  dconf.settings = {
    # disable dconf first use warning
    "ca/desrt/dconf-editor" = {
      show-warning = false;
    };
    # set dark theme for gtk 4
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      # gtk-decoration-layout = ":menu"; # disable title bar buttons
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    theme.package = pkgs.gnome-themes-extra;
    theme.name = "Adwaita-dark";

    #Fonts are already manager by stylix

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Inter";
      package = pkgs.google-fonts.override {fonts = ["Inter"];};
      size = 9;
    };
    cursorTheme = {
      inherit (config.home.pointerCursor) name package size;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    size = 32;
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
  };
}
