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
    du-dust
    duf
    fd
    file
    jaq
    ripgrep
  ];
}
