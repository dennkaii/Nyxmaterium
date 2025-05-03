{
  programs.nvf.settings.vim = {
    dashboard.startify = {
      enable = true;
      bookmarks = [
        {
          nyxmaterium = "~/projects/Nyxmaterium";
        }
      ];
      lists = [
        {
          header = [
            "Bookmarks"
          ];
          type = "bookmarks";
        }
        {
          header = [
            "MRU"
          ];
          type = "files";
        }
        {
          header = [
            "MRU Current Directory"
          ];
          type = "dir";
        }
        {
          header = [
            "Sessions"
          ];
          type = "sessions";
        }

        {
          header = [
            "Commands"
          ];
          type = "commands";
        }
      ];
    };
  };
}
