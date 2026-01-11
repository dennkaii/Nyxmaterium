{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
      };

      mango = {
        default = ["gtk"];
        "org.freedesktop.impl.portal.ScreenCast" = ["wlr"];
        "org.freedesktop.impl.portal.Screenshot" = ["wlr"];
      };

      niri = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.Access" = "gtk";
        "org.freedesktop.impl.portal.Notification" = "gtk";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        "org.freedesktop.impl.portal.Settings" = "gtk";
      };
    };
    wlr = {
      enable = true;
      settings = {
        screencast = {
          # Auto-select the output instead of using a chooser
          # This works around issues with wofi not displaying options
          chooser_type = "none";
          # Specify which output to use (DP-1 is your main monitor)
          outputname = "DP-1";
        };
      };
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
