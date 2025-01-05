{ packages, lib, config, ... }: {
  options.terminals.wezterm =  lib.mkOption {
    type = lib.types.bool;
    default = false;
  };
  config = lib.mkIf config.terminals.wezterm {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      colorSchemes = {
        mytheme = {
          foreground = "#CDD6F4";
          background = "#161718";
          selection_fg = "#1E1E2E";
          selection_bg = "#F5E0DC";
          cursor_bg = "#F5E0DC";
          cursor_fg = "#1E1E2E";
          tab_bar = {
            background = "#11111B";
          };
          ansi = [
            "#45475A"
            "#F38BA8"
            "#A6E3A1"
            "#F9E2AF"
            "#89B4FA"
            "#F5C2E7"
            "#94E2D5"
            "#BAC2DE"
          ];
          brights = [
            "#585B70"
            "#F38BA8"
            "#A6E3A1"
            "#F9E2AF"
            "#89B4FA"
            "#F5C2E7"
            "#94E2D5"
            "#A6ADC8"
          ];
        };
      };
      extraConfig = ''
        -- Pull in the wezterm API
    local wezterm = require 'wezterm'

    local SOLID_LEFT_ARROW = wezterm.nerdfonts.cod_list_flat

    -- The filled in variant of the > symbol
    local SOLID_RIGHT_ARROW = wezterm.nerdfonts.cod_list_flat

    -- This function returns the suggested title for a tab.
    -- It prefers the title that was set via `tab:set_title()`
    -- or `wezterm cli set-tab-title`, but falls back to the
    -- title of the active pane in that tab.
    local function tab_title(tab_info)
       local title = tab_info.tab_title
       -- if the tab title is explicitly set, take that
       if title and #title > 0 then
	  return title
       end
       -- Otherwise, use the title from the active pane
       -- in that tab
       return tab_info.active_pane.title
    end

    wezterm.on(
       'format-tab-title',
       function(tab, tabs, panes, config, hover, max_width)
	  local edge_background = '#0b0022'
	  local background = '#1b1032'
	  local foreground = '#808080'

          if tab.is_active then
	     background = '#CBA6F7'
	     foreground = '#11111B'
	     variant1 = '#3f3652'
	     variant2 = '#6e5b89'
	     variant3 = '#9c80c0'
          else
	     background = '#181825'
	     foreground = '#CDD6F4'
	     variant1 = '#12121d'
	     variant2 = '#141420'
	     variant3 = '#161622'
          end

          local edge_foreground = background

          local title = tab_title(tab)

          -- ensure that the titles fit in the available space,
          -- and that we have room for the edges.
          title = wezterm.truncate_right(title, max_width - 2)

          return {
	     { Background = { Color = variant1 } },
	     { Foreground = { Color = foreground } },
	     { Text = ' ' },
	     { Background = { Color = variant2 } },
	     { Foreground = { Color = foreground } },
	     { Text = ' ' },
	     { Background = { Color = variant3 } },
	     { Foreground = { Color = foreground } },
	     { Text = ' ' },
	     { Background = { Color = background } },
	     { Foreground = { Color = foreground } },
	     { Text = title },
	     { Background = { Color = variant3 } },
	     { Foreground = { Color = foreground } },
	     { Text = ' ' },
	     { Background = { Color = variant2 } },
	     { Foreground = { Color = foreground } },
	     { Text = ' ' },
	     { Background = { Color = variant1 } },
	     { Foreground = { Color = foreground } },
	     { Text = ' ' },
          }
       end
    )


    -- This table will hold the configuration.
    local config = {}

    -- In newer versions of wezterm, use the config_builder which will
    -- help provide clearer error messages
    if wezterm.config_builder then
       config = wezterm.config_builder()
    end

    -- This is where you actually apply your config choices

    -- For example, changing the color scheme:
    config.color_scheme = 'mytheme'
    -- Font
    config.font = wezterm.font('${packages.fonts.main.name}', { weight = 'Medium', style = 'Normal' })
    config.font_size = 13.0
    -- config.font_dirs = { '${packages.fonts.main.package}/share' }
    -- tab_bar
    config.hide_tab_bar_if_only_one_tab = true
    config.use_fancy_tab_bar = false
    config.show_tab_index_in_tab_bar = false
    config.show_new_tab_button_in_tab_bar = false
    config.tab_bar_at_bottom = true
    --kitty keyboard protocol
    config.enable_kitty_keyboard = true
    config.enable_kitty_graphics = true
    -- and finally, return the configuration to wezterm
    -- multiplexer
    config.unix_domains = {
       {
    name = 'unix',
       },
    }
    -- config.default_gui_startup_args = { 'connect', 'unix' }
    return config
      '';

    };
  };
}
