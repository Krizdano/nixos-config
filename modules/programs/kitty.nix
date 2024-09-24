{ pkgs, ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    font = {
      name = "FiraCode Nerd Font";
      package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
      size = 14;
    };
    keybindings = {
      "ctrl+shift+w" = "close_window_with_confirmation ignore-shell";
    };
    settings = {
      enable_audio_bell = false;
      scrollback_pager = '' nvim --noplugin -c "set signcolumn=no showtabline=0" -c "silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - "'';

      background_opacity = 1;
      dynamic_background_opacity = "yes";
      initial_window_width = "100c";
      initial_window_height = "25c";
      kitty_mod = "ctrl+shift";
      confirm_os_window_close = "-1";
      enabled_layouts = "Tall,Fat,Grid,Stack";
      window_padding_width = "4.0";
      allow_remote_control = "yes";
      inactive_text_alpha = "0.4";
      tab_activity_symbol = "٭";
    };
    extraConfig = "
       # The basic colors
       foreground              #CDD6F4
       background              #1e1e2e
       selection_foreground    #1E1E2E
       selection_background    #F5E0DC

       # Cursor colors
       cursor                  #F5E0DC
       cursor_text_color       #1E1E2E

       # URL underline color when hovering with mouse
       url_color               #F5E0DC

       # Kitty window border colors
       active_border_color     #B4BEFE
       inactive_border_color   #6C7086
       bell_border_color       #F9E2AF

       # OS Window titlebar colors
       wayland_titlebar_color system
       macos_titlebar_color system

       # Tab bar colors
       active_tab_foreground   #11111B
       active_tab_background   #CBA6F7
       inactive_tab_foreground #CDD6F4
       inactive_tab_background #181825
       tab_bar_background      #11111B

       # Colors for marks (marked text in the terminal)
       mark1_foreground #1E1E2E
       mark1_background #B4BEFE
       mark2_foreground #1E1E2E
       mark2_background #CBA6F7
       mark3_foreground #1E1E2E
       mark3_background #74C7EC

       # The 16 terminal colors

       # black
       color0 #45475A
       color8 #585B70

       # red
       color1 #F38BA8
       color9 #F38BA8

       # green
       color2  #A6E3A1
       color10 #A6E3A1

       # yellow
       color3  #F9E2AF
       color11 #F9E2AF

       # blue
       color4  #89B4FA
       color12 #89B4FA

       # magenta
       color5  #F5C2E7
       color13 #F5C2E7

       # cyan
       color6  #94E2D5
       color14 #94E2D5

       # white
       color7  #BAC2DE
       color15 #A6ADC8
      ";
  };
}
