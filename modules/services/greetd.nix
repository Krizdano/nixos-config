{ pkgs, username, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --user-menu  --time --cmd niri --session";
        user = "greeter";
      };
      initial_session = {
        command = "niri --session";
        user = "${username}";
      };
    };
  };
}
