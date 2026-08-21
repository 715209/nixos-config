{ inputs, pkgs, ... }:
{
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      systemd.enable = false;
      plugins = [
        inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
      ];
      settings = {
        monitor = [
          "HDMI-A-2, 1920x1080@144, 0x0, 1"
          "HDMI-A-1, 1920x1080, 1920x0, 1"
          ",preferred,auto,auto"
        ];

        # Set programs that you use
        "$terminal" = "ghostty";
        "$fileManager" = "dolphin";
        "$menu" = "wofi --show drun";
        "$mainMod" = "SUPER";

        # Startup Apps
        exec-once = [
          "waybar"
          "hyprpaper"
          #"hyprctl dispatch focusmonitor HDMI-A-2"
          "hyprctl dispatch split-workspace 1"
        ];

        # Environment Variables
        env = [
          "XCURSOR_SIZE,21"
          "HYPRCURSOR_SIZE,21"
          "XCURSOR_THEME,Adwaita"
          "HYPRCURSOR_THEME,Adwaita"
          "AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card2"
          #"AQ_DRM_DEVICES,/dev/dri/card0"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "LIBVA_DRIVER_NAME,nvidia"
          "NVD_BACKEND,direct"
        ];

        general = {
          gaps_in = 0;
          gaps_out = 0;
          border_size = 1;
          "col.active_border" = "rgba(818589aa)";
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 0;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = "no, please :)";
          
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];

          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 1.94, almostLinear, fade"
            "workspacesIn, 1, 1.21, almostLinear, fade"
            "workspacesOut, 1, 1.94, almostLinear, fade"
          ];
        };

        dwindle = {
          #pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = true;
          disable_splash_rendering = true;
          background_color = "0x000000";
        };

        plugin = {
          split-monitor-workspaces = {
            count = 10;
            keep_focused = 0;
            enable_notifications = 0;
            enable_persistent_workspaces = 1;
            link_monitors = 0;

            monitor_priority = [
              "HDMI-A-2"
            ];
          };
        };

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
          follow_mouse = 1;
          sensitivity = 0;

          touchpad = {
            natural_scroll = false;
          };

          repeat_delay = 300;
          repeat_rate = 50;
        };

        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        bind = [
          "$mainMod, S, exec, hyprshot -m region --clipboard-only"
          "$mainMod, Q, exec, $terminal"
          "$mainMod, C, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, R, exec, $menu"
          "$mainMod, P, pseudo,"
          "$mainMod SHIFT, J, layoutmsg, togglesplit,"
          "$mainMod, F, fullscreen, 1"
          "$mainMod SHIFT, F, fullscreen"
          
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"

          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"
          
          "$mainMod, 1, split-workspace, 1"
          "$mainMod, 2, split-workspace, 2"
          "$mainMod, 3, split-workspace, 3"
          "$mainMod, 4, split-workspace, 4"
          "$mainMod, 5, split-workspace, 5"
          "$mainMod, 6, split-workspace, 6"
          "$mainMod, 7, split-workspace, 7"
          "$mainMod, 8, split-workspace, 8"
          "$mainMod, 9, split-workspace, 9"
          "$mainMod, 0, split-workspace, 10"

          "$mainMod SHIFT, 1, split-movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, split-movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, split-movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, split-movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, split-movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, split-movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, split-movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, split-movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, split-movetoworkspacesilent, 9"
          "$mainMod SHIFT, 0, split-movetoworkspacesilent, 10"

          # "$mainMod, S, togglespecialworkspace, magic"
          # "$mainMod SHIFT, S, movetoworkspace, special:magic"
          "$mainMod, mouse_down, split-cycleworkspaces, +1"
          "$mainMod, mouse_up, split-cycleworkspaces, -1"
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Laptop multimedia keys for volume and LCD brightness
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ];


        # Requires playerctl
        bindl = [
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPrev, exec, playerctl previous"
        ];
      };
    };
}
