{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    # ML4W Hyprland Ecosystem Dependencies
    waybar
    rofi-wayland # Kept for dmenu functionality with cliphist
    walker
    playerctl
    swaynotificationcenter
    wlogout
    swaybg
    
    # Screenshot utilities
    grim
    slurp
    wl-clipboard
    swappy
    
    # QoL Tools
    cliphist
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      monitor = ",preferred,auto,auto";
      
      exec-once = [
        "waybar"
        "swaybg -m fill -i ${../../wallpapers/ml4w_tokyonight.png}"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # ML4W Style General Settings
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        # "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        # "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };

      # ML4W Decoration (Blur, Rounded Corners, Transparency)
      decoration = {
        rounding = 10;
        
        active_opacity = 0.90;
        inactive_opacity = 0.85;
        fullscreen_opacity = 1.0;
        
        blur = {
          enabled = true;
          size = 8;
          passes = 2;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      # ML4W Signature Animations
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        preserve_split = true;
      };

      master = {
      };

      # ML4W Keybindings
      "$mainMod" = "SUPER";
      bind = [
        "$mainMod, Return, exec, kitty"
        "$mainMod, Q, killactive, "
        "$mainMod, M, exit, "
        "$mainMod, E, exec, kitty -o font_size=16 -e yazi"
        "$mainMod SHIFT, Space, togglefloating, "
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod, Tab, exec, rofi -show window"
        "$mainMod, Space, exec, rofi -show drun -show-icons"
        "$mainMod, Escape, exec, wlogout"
        "$mainMod, P, pseudo, "
        "$mainMod, J, layoutmsg, togglesplit"
        
        # Media controls
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        
        # Navigation
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        
        # Workspaces
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        
        # Move active window to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Screenshot bindings
        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
      ];
      
      bindm = [
        # Mouse movements
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
  };

  # Configure Waybar to have rounded ML4W styling
  programs.waybar = {
    enable = true;
    style = ''
      * {
          border: none;
          border-radius: 10px;
          font-family: "MesloLGS Nerd Font Mono", "Font Awesome 5 Free";
          font-size: 14px;
          min-height: 0;
      }
      
      window#waybar {
          background: rgba(30, 30, 46, 0.8);
          color: #cdd6f4;
      }
      
      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: #cdd6f4;
          border-bottom: 2px solid transparent;
      }
      
      #workspaces button.focused {
          background: #313244;
          border-bottom: 2px solid #89b4fa;
      }
      
      #clock,
      #battery,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #tray,
      #custom-weather,
      #custom-launcher,
      #custom-power,
      #mpris {
          padding: 0 10px;
          margin: 0 5px;
          background-color: #313244;
          border-radius: 10px;
      }

      #custom-launcher {
          color: #89b4fa;
          font-size: 18px;
          padding-right: 15px;
          padding-left: 15px;
      }

      #custom-power {
          color: #f38ba8;
          font-size: 16px;
          padding-right: 15px;
          padding-left: 15px;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        modules-left = ["custom/launcher" "hyprland/workspaces" "custom/power"];
        modules-center = ["cpu" "memory" "battery"];
        modules-right = ["tray" "mpris" "custom/weather" "clock"];
        
        "custom/launcher" = {
          format = "";
          on-click = "rofi -show drun -show-icons";
          tooltip = false;
        };

        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
          tooltip = false;
        };

        "custom/weather" = {
          exec = "${pkgs.curl}/bin/curl -s 'https://wttr.in/?format=1'";
          interval = 1800;
          format = "{}";
          tooltip = false;
        };

        cpu = {
          format = " {usage}%";
          tooltip = false;
        };

        memory = {
          format = " {}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["" "" "" "" ""];
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} {dynamic}";
          player-icons = { default = "🎵"; };
          status-icons = { paused = "⏸"; };
        };

        clock = {
          format = "{:%I:%M %p}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };
  };

  # Configure Wlogout
  programs.wlogout = {
    enable = true;
    layout = [
      { label = "lock"; action = "hyprlock"; text = "Lock"; keybind = "l"; }
      { label = "hibernate"; action = "systemctl hibernate"; text = "Hibernate"; keybind = "h"; }
      { label = "logout"; action = "hyprctl dispatch exit 0"; text = "Logout"; keybind = "e"; }
      { label = "shutdown"; action = "systemctl poweroff"; text = "Shutdown"; keybind = "s"; }
      { label = "suspend"; action = "systemctl suspend"; text = "Suspend"; keybind = "u"; }
      { label = "reboot"; action = "systemctl reboot"; text = "Reboot"; keybind = "r"; }
    ];
  };

  # Lock screen (Hyprlock)
  programs.hyprlock.enable = true;

  # Idle daemon (Hypridle)
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
