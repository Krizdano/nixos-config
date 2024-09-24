_: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };
      background = {
        # path = "${config.xdg.userDirs.pictures}/.backup_wallpaper.png";
        path = "screenshot";
        color = "rgba(25, 20, 20, 1.0)";
        blur_passes = 2;
        # blur_size = 5;
      };
      input-field = {
        outer_color = "rgb(BAC2DE)";
        inner_color = "rgb(1E1E2E)";
        font_color = "rgb(f8f8f2)";
        check_color = "rgb(F9E2AF)";
        fail_color = "rgb(ff5555)";
        size = "300, 48";
        outline_thickness = 1;
        position = "0, 48";
        rounding = 10;
        halign = "center";
        valign = "bottom";
        placeholder_text = ''<span font_family="Fira Code">password</span>'';
        fail_text = ''<span font_family="Fira Code">Wrong password</span>'';
      };
    };
    extraConfig = ''
       label {
          text = cmd[update:1000] echo "<b><big> $(date +"%H") </big></b>"
          font_size = 128
          font_family = FiraCode Nerd Font Medium 10
          position = 0, 80
          halign = center
          valign = center
       }
       label {
          text = cmd[update:1000] echo "<b><big> $(date +"%M") </big></b>"
          font_size = 128
          font_family = FiraCode Nerd Font Medium 10
          position = 0, -80
          halign = center
          valign = center
       }
       label {
          text = cmd[update:1000] echo "<b><big> $(date +"%d %b") </big></b>"
          font_size = 16
          font_family = FiraCode Nerd Font Medium 10
          position = 0, -180
          halign = center
          valign = center
       }
       label {
          text = cmd[update:1000] echo "<b><big> $(date +"%A") </big></b>"
          font_size = 16
          font_family = FiraCode Nerd Font Medium 10
          position = 0, -200
          halign = center
          valign = center
       }
   '';
  };
}
