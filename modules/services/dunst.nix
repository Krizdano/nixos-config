{ pkgs, ... }: {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "mouse";
        width = "(0, 300)";
        height = 300;
        font = "Iosevka Nerd Font 11";
        indicate_hidden = "yes";
        shrink = "no";
        transparency = 0;
        offset = "30x20";
        origin = "top-right";
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        frame_width = 3;
        frame_color = "#151515";
        separator_color = "#151515";
        sort = "yes";
        line_height = 0;
        markup = "full";
        format = ''<b>%s</b>\n%b'';
        alignment = "center";
        word_wrap = "yes";
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = "true";
        show_indicators = "yes";
        icon_position = "left";
        max_icon_size = 32;
        browser = "usr/bin/env firefox";
        corner_radius = 5;
        mouse_left_click = "do_action";
        mouse_middle_click = "close_all";
        mouse_right_click = "close_current";
        close = "control+space";
      };
      urgency_low = {
        background = "#FFFFFF";
        foreground = "#151515";
        timeout = 5;
      };
      urgency_normal = {
        background = "#FFFFFF";
        foreground = "#151515";
        timeout = 5;
      };
      urgency_critical = {
        background = "#FF6D6A";
        foreground = "#151515";
        timeout = 5;
      };
    };
  };

  home.packages = with pkgs; [
    libnotify
  ];

}
