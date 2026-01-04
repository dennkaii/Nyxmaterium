{...}: {
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.fuse.userAllowOther = true;
}
