{pkgs, ...}: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # misc
    libnotify
    sshfs

    # utils
    duf
    dust
    fd
    file
    jaq
    ripgrep
  ];
}
