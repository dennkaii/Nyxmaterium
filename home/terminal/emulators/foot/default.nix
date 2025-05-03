{...}: {
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "foot";
        font-size-adjustment = "7.5%";
        pad = "5x5 center";
      };
      cursor = {
        style = "beam";
        blink = true;
      };
      mouse = {
        hide-when-typing = true;
      };
    };
  };
}
