{shellAliases}: {config, lib, osConfig, pkgs, ...}: {
  config = lib.mkIf (osConfig.users.defaultUserShell == pkgs.nushell || builtins.elem "nushell" config.shells.list) {
    programs.nushell = {
      enable = true;
      shellAliases = shellAliases.nushell;
      configFile = {
        text = ''
          $env.config = {
          show_banner: false,
          edit_mode: vi
          cursor_shape: {
           vi_insert: line
           vi_normal: block
          }

          menus: [
              {
                name: completion_menu
                only_buffer_difference: false # Search is done on the text written after activating the menu
                marker: "| "                  # Indicator that appears with the menu is active
                type: {
                    layout: columnar          # Type of menu
                    columns: 4                # Number of columns where the options are displayed
                    col_padding: 2            # Padding between columns
                }
                style: {
                    text: blue                    # Text style
                    selected_text: green_reverse  # Text style for selected option
                    description_text: black       # Text style for description
                }
              }
          ]
        }
        $env.PROMPT_INDICATOR_VI_INSERT = ""
        $env.PROMPT_INDICATOR_VI_NORMAL = ""
        '';
      };
    };
  };
}
