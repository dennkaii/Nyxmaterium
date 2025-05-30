{
  pkgs,
  config,
  ...
}: let
  fonts = with pkgs; [
    material-symbols
    font-awesome_5
    # normal fonts
    noto-fonts-cjk-sans
    noto-fonts
    noto-fonts-emoji
    roboto
    monaspace
    # maple-mono.NF
    # sf-mono-liga-bin
    corefonts

    # (nerdfonts.override {fonts = ["Mononoki" "JetBrainsMono" "FiraCode"];})
  ];
in {
  fonts = {
    # fontconfig.defaultFonts = {
    #   serif = ["Maple Mono NF"];
    #   sansSerif = ["Maple Mono NF"];
    #   monospace = ["Maple Mono NF"];
    # };
    packages = fonts;
  };
}
