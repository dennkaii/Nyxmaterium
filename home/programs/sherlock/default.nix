{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sherlock.homeManagerModules.default];

  programs.sherlock = {
    enable = true;
    settings = {
      aliases = {
        vesktop = {
          name = "Discord";
        };
      };
      config = {
        debug = {
          try_suppress_warnings = true;
        };
      };
      ignore = ''
        Avahi*
      '';
      launchers = [
        {
          name = "App Launcher";
          type = "app_launcher";
          args = {};
          priority = 1;
          home = true;
        }
        {
          name = "Web Launcher";
          type = "web_launcher";
          display_name = "Search";
          tag_start = "{keyword}";
          tag_end = "{keyword}";
          args = {
            searchn_engine = "google";
            icon = "google";
          };
          alias = "gg";
          priority = 0;
        }
      ];
    };
  };
}
