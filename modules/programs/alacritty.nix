{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [
        "${pkgs.alacritty-theme}/catppuccin_mocha.toml"
      ];
      font = {
        normal = {
          family = "Iosevka Nerd Font";
        };
        size = 14.0;
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
}
