{pkgs, ...}: let
  jdks = with pkgs; [
    # Java 8
    temurin-jre-bin-8
    zulu8

    # Java 11
    temurin-jre-bin-11

    # Java 17
    temurin-jre-bin-17

    # Latest
    temurin-jre-bin
    zulu
    graalvm-ce
  ];

  additionalPrograms = with pkgs; [
    gamemode
    mangohud
  ];
in {
  users.epackages = with pkgs; [
    (pkgs.prismlauncher.override {
      inherit jdks;
      inherit additionalPrograms;
    })
  ];
}
