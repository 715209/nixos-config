{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        reload_style_on_change = true;
        layer = "top";
        position = "top";
        spacing = 0;
        height = 26;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "group/tray-expander"
          "bluetooth"
          "network"
          "pulseaudio"
          "cpu"
          "battery"
        ];

        "hyprland/workspaces" = {
          on-click = "activate";
          format = "{icon}";
          format-icons = {
            active = "󱓻";
          };
        };

        cpu = {
          interval = 5;
          format = "󰍛";
          on-click = "omarchy-launch-or-focus-tui btop";
          on-click-right = "alacritty";
        };

        clock = {
          format = "{:L%A %H:%M}";
          format-alt = "{:L%d %B W%V %Y}";
          tooltip = false;
          on-click-right = "omarchy-launch-floating-terminal-with-presentation omarchy-tz-select";
        };

        network = {
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          format = "{icon}";
          format-wifi = "{icon}";
          format-ethernet = "󰀂";
          format-disconnected = "󰤮";
          tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-disconnected = "Disconnected";
          interval = 3;
          spacing = 1;
          on-click = "omarchy-launch-wifi";
        };

        battery = {
          format = "{capacity}% {icon}";
          format-discharging = "{icon}";
          format-charging = "{icon}";
          format-plugged = "";
          format-icons = {
            charging = [ "󰢜" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅" ];
            default = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          };
          format-full = "󰂅";
          tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
          tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
          interval = 5;
          on-click = "omarchy-menu power";
          states = {
            warning = 20;
            critical = 10;
          };
        };

        bluetooth = {
          format = "";
          format-off = "󰂲";
          format-disabled = "󰂲";
          format-connected = "󰂱";
          format-no-controller = "";
          tooltip-format = "Devices connected: {num_connections}";
          on-click = "omarchy-launch-bluetooth";
        };

        pulseaudio = {
          format = "{icon}";
          on-click = "pavucontrol";
          on-click-right = "pamixer -t";
          tooltip-format = "Playing at {volume}%";
          scroll-step = 5;
          format-muted = "";
          format-icons = {
            headphone = "";
            headset = "";
            default = ["" "" ""];
          };
        };

        "group/tray-expander" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 600;
            children-class = "tray-group-item";
          };
          modules = [ "custom/expand-icon" "tray" ];
        };

        "custom/expand-icon" = {
          format = "";
          tooltip = false;
          on-scroll-up = "";
          on-scroll-down = "";
          on-scroll-left = "";
          on-scroll-right = "";
        };

        "custom/screenrecording-indicator" = {
          on-click = "omarchy-cmd-screenrecord";
          exec = "$OMARCHY_PATH/default/waybar/indicators/screen-recording.sh";
          signal = 8;
          return-type = "json";
        };

        "custom/voxtype" = {
          exec = "omarchy-voxtype-status";
          return-type = "json";
          format = "{icon}";
          format-icons = {
            idle = "";
            recording = "󰍬";
            transcribing = "󰔟";
          };
          tooltip = true;
          on-click-right = "omarchy-voxtype-config";
          on-click = "omarchy-voxtype-model";
        };

        tray = {
          icon-size = 12;
          spacing = 17;
        };
      };
    };

    style = ''
      @define-color foreground #cdd6f4;
      @define-color background #000000;

      * {
        background-color: @background;
        color: @foreground;

        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: 'JetBrainsMono Nerd Font';
        font-size: 12px;
      }

      .modules-left {
        margin-left: 8px;
      }

      .modules-right {
        margin-right: 8px;
      }

      #workspaces button {
        all: initial;
        padding: 0 6px;
        margin: 0 1.5px;
        min-width: 9px;
      }

      #workspaces button.empty {
        opacity: 0.5;
      }

      #cpu,
      #battery,
      #pulseaudio,
      #custom-omarchy,
      #custom-screenrecording-indicator,
      #custom-update {
        min-width: 12px;
        margin: 0 7.5px;
      }

      #tray {
        margin-right: 16px;
      }

      #bluetooth {
        margin-right: 17px;
      }

      #network {
        margin-right: 13px;
      }

      #custom-expand-icon {
        margin-right: 18px;
      }

      tooltip {
        padding: 2px;
      }

      #custom-update {
        font-size: 10px;
      }

      #clock {
        margin-left: 8.75px;
      }

      .hidden {
        opacity: 0;
      }

      #custom-screenrecording-indicator {
        min-width: 12px;
        margin-left: 5px;
        font-size: 10px;
        padding-bottom: 1px;
      }

      #custom-screenrecording-indicator.active {
        color: #a55555;
      }

      #custom-voxtype {
        min-width: 12px;
        margin: 0 0 0 7.5px;
      }

      #custom-voxtype.recording {
        color: #a55555;
      }
    '';
  };
}
