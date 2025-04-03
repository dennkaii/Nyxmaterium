{
  pkgs,
  config,
  ...
}: {
  services.searx = {
    enable = true;
    redisCreateLocally = true;

    settings = {
      server = {
        secret_key = "aaaaaa";
        port = 8181;
        bind_address = "0.0.0.0";
      };
      search = {
        formats = ["html" "json" "rss"];
      };
    };
  };
}
