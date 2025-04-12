{
  pkgs,
  config,
  lib,
  ...
}: let
  # enable DRM support on webkit
  webkitgtk-eme = pkgs.webkitgtk_4_1.overrideAttrs (oldAttrs: rec {
    buildInputs =
      oldAttrs.buildInputs
      ++ [
        pkgs.libgpg-error
      ];
    cmakeFlags =
      oldAttrs.cmakeFlags
      ++ [
        "-DENABLE_ENCRYPTED_MEDIA=ON"
      ];
  });
in {
  config = {
    wrappers.nyxt = {
      basePackage = pkgs.nyxt.overrideAttrs (oldAttrs: rec {
        pname = "nyxt4-3";
        version = "4.0.0-pre-release-3";
        src = pkgs.fetchzip {
          url = "https://github.com/atlas-engineer/nyxt/releases/download/${version}/nyxt-${version}-source-with-submodules.tar.xz";
          hash = "sha256-T5p3OaWp28rny81ggdE9iXffmuh6wt6XSuteTOT8FLI=";
          stripRoot = false;
        };
        LD_LIBRARY_PATH =
          lib.makeLibraryPath
          [
            pkgs.glib
            pkgs.gobject-introspection
            pkgs.gdk-pixbuf
            pkgs.cairo
            pkgs.pango
            pkgs.gtk3
            pkgs.openssl
            pkgs.libfixposix
            webkitgtk-eme
          ];
      });
    };
  };
}
