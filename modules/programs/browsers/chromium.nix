{ lib, config, ... }: {
  options.browsers.chromium = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = lib.mkIf config.browsers.chromium {
    programs.chromium = {
      enable = true;
    };
  };
}
