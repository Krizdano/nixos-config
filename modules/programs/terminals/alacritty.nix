{ pkgs, packages, lib, config, ... }: {
  options.terminals.alacritty = lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = lib.mkIf config.terminals.alacritty {
    programs.alacritty = {
      enable = true;
      settings = {
        general.import = [
          "${pkgs.alacritty-theme}/catppuccin_mocha.toml"
        ];
        font = {
          normal = {
            family = packages.fonts.main.name;
          };
          size = 16.0;
          offset = {
            x = 1;
          };
        };
        window = {
          padding = {
            x = 8;
          };
        };
      };
    };
  };
}
