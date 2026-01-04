{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.nyxt.packages.${pkgs.stdenv.hostPlatform.system}.nyxt-source
  ];
  home.  sessionVariables = {
    WEBKIT_DISABLE_COMPOSITING_MODE = 1;
  };
}
