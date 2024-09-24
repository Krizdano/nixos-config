_: {
  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family:'Ubuntu Nerd Font';
        padding-left: 3px;
        padding-right: 3px;
      }

      window#waybar {
        background: transparent;
        color: #dcd7ba;
      }

      tooltip {
        background: #1f1f28;
        border-radius: 15px;
        border-width: 2px;
        border-style: solid;
        border-color: #7e9cd8;
        font-size: 13pt;
      }

      tooltip label {
        padding: 7px;
      }

      #workspaces {
        background: #16161d;
        font-size: 18pt;
        padding-top: 10px;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
        padding-bottom: 10px;
      }

      #workspaces button {
        color: #dcd7ba;
        padding-top: 10px;
        padding-bottom: 10px;
      }

      #workspaces button.focused {
        color: #7e9cd8;
      }

      #workspaces button.active {
        color: #7e9cd8;
      }

      #workspaces button.urgent {
        color: #e6c384;
      }

      #workspaces button:hover {
        background: #1f1f28;
        border-color: #1f1f28;
        color: #7e9cd8;
      }

      #network, #pulseaudio, #pulseaudio.percentage, #battery, #battery.percentage, #custom-vpn, #custom-calendar-icon, #clock, #clock.date, #custom-time-icon, #clock.time, #tray {
        background: #1f1f28;
        border-radius: 0px;
      }

      #memory, #cpu, #custom-gpu-usage {
        background-color: #332E41;
        border-radius: 0px;
      }

      #network {
        padding-top: 10px;
        padding-bottom: 0px;
        font-size: 14pt;
        color: #F2CECF;
      }

      #pulseaudio {
        padding-top: 10px;
        color: #cba6f7;
        background: #1f1f28;
        font-size: 14pt;
      }

      #pulseaudio.percentage {
        font-size: 11pt;
        padding-top: 10px;
        padding-bottom: 0px;
        color: #FFFFFF;
      }

      #battery {
        padding-top: 10px;
        font-size: 18pt;
        color: #94e2d5;
      }

      #battery.percentage {
        padding-top: 10px;
        font-size: 11pt;
        color: #FFFFFF;
      }

      #tray {
        padding-top: 0px;
        font-size: 18pt;
        padding-bottom: 10px;
      }

      #custom-calendar-icon {
        padding-top: 10px;
        font-size: 10pt;
        color: #957fb8;
      }


      #custom-time-icon {
        padding-top: 10px;
        font-size: 18pt;
        color: #7fb4ca;
      }

      #clock.time {
        padding-top: 10px;
        padding-bottom: 2px;
        font-size: 11pt;
        color: #FFFFFF;
      }

      #clock {
        padding-top: 10px;
        font-size: 11pt;
        color: #FFFFFF;
      }

      #clock.date {
        padding-top: 1px;
        font-size: 11pt;
        padding-bottom: 10px;
        color: #FFFFFF;
      }

      #cpu {
        padding-top: 10px;
        padding-bottom: 0px;
        font-size: 14pt;
        color: #F2CECF;
        /* color: #7fb4ca; */
      }

      #cpu.percentage {
        font-size: 11pt;
        padding-top: 10px;
        padding-bottom: 0px;
        color: #FFFFFF;
      }

      #custom-gpu-usage {
        padding-top: 10px;
        padding-bottom: 0px;
        font-size: 14pt;
        color: #F2CECF;
      }

      #custom-gpu-usage.percentage {
        font-size: 11pt;
        padding-top: 10px;
        padding-bottom: 0px;
        color: #FFFFFF;
      }

      #memory {
        padding-top: 10px;
        padding-bottom: 10px;
        font-size: 14pt;
        color: #F2CECF;
      }

      #memory.percentage {
        font-size: 11pt;
        padding-top: 0px;
        padding-bottom: 10px;
        color: #FFFFFF;
        border-bottom-left-radius: 15px;
        border-bottom-right-radius: 15px;
      }
    '';
  };

  home.file.".config/waybar/config" = {
    text = ''
      {
        "layer": "top",
        "position": "left", 
        "height": 24,
        "margin-left": 10,
        "exclusive": false,
        "passthrough": false,
        "modules-center": ["sway/workspaces", "hyprland/workspaces", "network", "pulseaudio", "pulseaudio#percentage", "battery","battery#percentage", "custom/time-icon", "clock#time", "clock", "clock#date", "tray"],
      "modules-right": ["cpu", "cpu#percentage", "custom/gpu-usage", "custom/gpu-usage#percentage", "memory",  "memory#percentage"],
          // Modules configuration
        "sway/workspaces": {
          "format": "{icon}",
          "on-click": "activate",
          "sort-by-name": true,
          "format-icons": {
                  "1": "1",
                  "2": "󰻞",
                  "3": "3",
                  "video": "",
                  "telegram": "",
                  "6": "6",
                  "7": "7",
                  "8": "8",
                  "9": "9",
                  "browser": "󰈹"
               }
           },
        "hyprland/workspaces": {
          "format": "{icon}",
          "on-click": "activate",
          "sort-by-name": true,
          "format-icons": {
             "1": "1",
             "2": "󰻞",
             "3": "3",
             "video": "",
             "telegram": "",
             "6": "",
             "7": "",
             "8": "",
             "browser": "󰈹"
           }
        },
        "network": {
          "format-wifi": "",
          "format-ethernet": "󰈀",
          "format-linked": "{ifname} (No IP) ",
          "format-disconnected": "󰖪",
          "on-click": "nmcli device disconnect wlan0 || nmcli device connect wlan0",
          "on-double-click": "kitty -e nmtui",
          "tooltip-format-wifi": "{essid}",
          "tooltip-format-disconnected": "Disconnected"
        },
        "pulseaudio": {
          "on-click": "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
          "format": "{icon}",
          "format-muted": "",
          "format-icons": {
            "headphone": "󰋋",
            "hands-free": "",
            "headset": "󰋎",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", ""]
          }
        },
        "pulseaudio#percentage": {
          "on-click": "pactl set-sink-mute @DEFAULT_SINK@ toggle",
          "format": "{volume}",
          "tooltip": false
        },
        "cpu": {
          "format": ""
        },
        "cpu#percentage": {
          "format": "{usage}%",
          "tooltip": false
        },
        "custom/gpu-usage": {
          "format": "",
          "tooltip": false
        },
        "custom/gpu-usage#percentage": {
          "exec": "cat /sys/class/hwmon/hwmon6/device/gpu_busy_percent",
          "format": "{}%",
          "return-type": "",
          "interval": 1,
          "tooltip": false
        },
        "memory": {
          "format": ""
        },
        "memory#percentage": {
          "format": "{}%",
          "tooltip": false
        },
        "battery": {
          "states": {
             "warning": 30,
             "critical": 15
           },
          "format": "{icon}",
          "format-warning": "<span foreground='#94e2d5'>{icon}</span>",
          "format-critical": "<span foreground='#e46876'>{icon}</span>",
          "format-charging": "<span foreground='#94e2d5'>󰂄</span>",
          "format-plugged": "<span foreground='#94e2d5'></span>",
          "format-full": "<span foreground='#94e2d5'>󰁹</span>",
          "format-icons": ["󰁺", "󰁼", "󰁿", "󰁿", "󰂁"]
        },
        "battery#percentage": {
          "format": "{capacity}%",
          "tooltip": false
        },
        "custom/calendar-icon": {
          "format": "",
          "tooltip": false
        },
        "clock": {
          "format": "{:%a}",
          "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
        },
        "clock#date": {
          "format": "{:%d}",
          "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>"
        },
        "custom/time-icon": {
          "format": "󱑃",
          "tooltip": false
        },
        "clock#time": {
        "format": "{:%H\n%M}"
        },
      "tray": {
        "icon-size": 21,
        "spacing": 10
      }
     }
    '';
  };
}
