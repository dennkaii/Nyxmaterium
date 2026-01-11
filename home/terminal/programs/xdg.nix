{
  pkgs,
  config,
  inputs,
  ...
}: let
  browser = ["zen"];
  imageViewer = ["oculante"];
  videoPlayer = ["io.github.celluloid_player.Celluloid"];
  audioPlayer = ["io.bassi.Amberol"];

  xdgAssociations = type: program: list:
    builtins.listToAttrs (map (e: {
        name = "${type}/${e}";
        value = program;
      })
      list);

  image = xdgAssociations "image" imageViewer ["png" "svg" "jpeg" "gif"];
  video = xdgAssociations "video" videoPlayer ["mp4" "avi" "mkv"];
  audio = xdgAssociations "audio" audioPlayer ["mp3" "flac" "wav" "aac"];
  browserTypes =
    (xdgAssociations "application" browser [
      "json"
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) ({
      "application/pdf" = ["org.pwmt.zathura-pdf-mupdf"];
      "x-scheme-handler/element" = ["Element"];
      "x-scheme-handler/steamlink" = ["steam"];
      "x-scheme-handler/steam" = ["steam"];
      "text/html" = browser;
      "inode/directory" = ["superfile"];
      "text/plain" = ["Neovim"];
      # "x-scheme-handler/chrome" = ["chromium-browser"];
    }
    // image
    // video
    // audio
    // browserTypes);
in {
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };

  home.packages = with pkgs; [
    (inputs.superfile.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: {doCheck = false;}))
    # oculante
    zathura
    celluloid
    amberol
    zathura
    xdg-utils
  ];
}
