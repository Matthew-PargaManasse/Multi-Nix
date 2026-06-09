{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # ML4W Hyprland Ecosystem Dependencies
    waybar
    rofi # Replaced X11 rofi to fix Wayland compatibility and crashes
    walker
    playerctl
    swaynotificationcenter
    hyprpaper
    swayosd
    (pkgs.writeShellScriptBin "wlogout-centered" ''
      # Get the resolution of the currently focused monitor
      WIDTH=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .width')
      HEIGHT=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .height')
      
      # We want the grid to be exactly 1/3 of the screen width
      GRID_WIDTH=$(( WIDTH / 3 ))
      
      # For a 3x2 grid of perfect squares, the grid height must be 2/3 of the grid width
      GRID_HEIGHT=$(( GRID_WIDTH * 2 / 3 ))
      
      MARGIN_L=$(( (WIDTH - GRID_WIDTH) / 2 ))
      MARGIN_R=$(( MARGIN_L ))
      MARGIN_T=$(( (HEIGHT - GRID_HEIGHT) / 2 ))
      MARGIN_B=$(( MARGIN_T ))
      
      # Launch wlogout with calculated grid margins (defaults to 3 buttons per row)
      wlogout -b 3 -L $MARGIN_L -R $MARGIN_R -T $MARGIN_T -B $MARGIN_B
    '')

    # Screenshot utilities
    grim
    slurp
    wl-clipboard
    swappy

    # QoL Tools
    cliphist
    polkit_gnome
  ];


  # Force disable Hyprpaper service
  services.hyprpaper.enable = lib.mkForce false;

  # Enable swayosd for OSD indicators
  services.swayosd.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    configType = "hyprlang"; # Force traditional parsing, as bleeding-edge Home Manager defaults to experimental 'lua'

    extraConfig = ''
      # Source dynamic colors from Wallust BEFORE using them
      source = ~/.config/wallust/hyprland-colors.conf
      
      # -----------------------------------------------------
      # MULTI-PROFILE MONITOR CONFIGURATION
      # -----------------------------------------------------
      # Laptop screen (Bottom Left)
      monitor=desc:AU Optronics 0x633D,1920x1080@60.05,0x1080,1
      
      # WORK DESK: Top External Monitor (Samsung) (Top Right)
      monitor=desc:Samsung Electric Company C34H89x HCPR501463,1920x1080@60.00,1920x0,1
      
      # WORK DESK: Bottom External Monitor (Sceptre) (Bottom Right)
      monitor=desc:Sceptre Tech Inc Sceptre B34 0000000000000,2560x1080@60.01,1920x1080,1
      
      # HOME DESK / ANY OTHER: Fallback rule automatically places new monitors to the right
      monitor=,preferred,auto,1
    '';

    settings = {
      # Essential Wayland environment variables (Hardware Agnostic)
      env = [
        "XDG_SESSION_TYPE,wayland"
      ];

      exec-once = [
        "~/.config/hypr/wallpaper-daemon.sh &"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
        "swaync"
        "nm-applet --indicator"
      ];



      # ML4W Style General Settings
      general = {
        gaps_in = 3;
        gaps_out = 1;
        border_size = 2;
        layout = "dwindle";
      };


      # ML4W Decoration (Blur, Rounded Corners, Transparency)
      decoration = {
        rounding = 10;

        active_opacity = 0.70;
        inactive_opacity = 0.55;
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
        "$mainMod, W, exec, killall wallpaper-daemon.sh ; ~/.config/hypr/wallpaper-daemon.sh &"
        "$mainMod, B, exec, brave"
        # Hardware Graphics Driver / Monitor Reset (Mimics Windows Ctrl+Shift+Win+B)
        "$mainMod CTRL SHIFT, B, exec, sh -c 'hyprctl dispatch dpms off && sleep 1 && hyprctl dispatch dpms on'"
        "$mainMod, S, exec, spotify"
        "$mainMod SHIFT, Space, togglefloating, "
        "$mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        "$mainMod, Tab, exec, rofi -show window"
        "$mainMod, Space, exec, rofi -show drun -show-icons"
        "$mainMod, Escape, exec, wlogout-centered"
        "$mainMod, P, pseudo, "
        "$mainMod, J, layoutmsg, togglesplit"


        # Window State
        "$mainMod, F, fullscreen, 0" # True fullscreen (hides Waybar)
        "$mainMod SHIFT, F, fullscreen, 1" # Maximize (keeps Waybar visible)
        
        # Minimize (Hide to special workspace)
        "$mainMod, N, movetoworkspacesilent, special:minimized"
        "$mainMod SHIFT, N, togglespecialworkspace, minimized"

        "ALT, Tab, cyclenext, " # Alt-Tab equivalent
        "ALT, Tab, bringactivetotop, "

        # Navigation (Focus)
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Moving Windows (Keyboard)
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movewindow, u"
        "$mainMod SHIFT, down, movewindow, d"

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

        # Screenshot bindings (Full screen vs Region)
        ", Print, exec, grim - | swappy -f -"
        "$mainMod, Print, exec, sh -c 'grim -g \"$(slurp)\" - | swappy -f -'"
      ];

      bindel = [
        # Media controls (e = repeat, l = works when locked)
        ", XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
        ", XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
        ", XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
        ", XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
        ", XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
        ", XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
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
      @import "/home/mitch/.config/wallust/waybar-colors.css";

      * {
          border: none;
          border-radius: 10px;
          font-family: "MesloLGS Nerd Font Mono", "Font Awesome 5 Free";
          font-size: 14px;
          min-height: 0;
      }

      window#waybar {
          background: alpha(@background, 0.8);
          color: @foreground;
      }

      #workspaces button {
          padding: 0 5px;
          background: transparent;
          color: @foreground;
          border-bottom: 2px solid transparent;
      }

      #workspaces button.focused {
          background: @color0;
          border-bottom: 2px solid @color4;
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
      #mpris,
      #window,
      #taskbar {
          padding: 0 10px;
          margin: 0 5px;
          background-color: @color0;
          border-radius: 10px;
      }

      #cpu { color: @color2; }
      #memory { color: @color3; }
      #battery { color: @color1; }
      #network.traffic { color: @color4; }

      #custom-launcher {
          color: @color4;
          font-size: 18px;
          padding-right: 15px;
          padding-left: 15px;
      }

      #custom-power {
          color: @color1;
          font-size: 18px;
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
        modules-center = ["cpu" "memory" "battery" "network#traffic"];
        modules-right = ["wlr/taskbar" "tray" "mpris" "network" "clock"];

        "hyprland/window" = {
          format = "👉 {}";
          max-length = 50;
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 14;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
        };

        "custom/launcher" = {
          format = "";
          on-click = "rofi -show drun -show-icons";
          tooltip = false;
        };

        "custom/power" = {
          format = "⏻";
          on-click = "wlogout-centered";
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

        network = {
          format-wifi = " {ipaddr}";
          format-ethernet = " {ipaddr}";
          format-disconnected = "⚠ Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
        };

        "network#traffic" = {
          format = "⬆️ {bandwidthUpBytes} ⬇️ {bandwidthDownBytes}";
          interval = 1;
        };

        mpris = {
          format = "{player_icon} {dynamic}";
          format-paused = "{status_icon} {dynamic}";
          player-icons = {default = "🎵";};
          status-icons = {paused = "⏸";};
        };

        clock = {
          format = "{:%I:%M %p  %a %d %b %y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      };
    };
  };

  # Configure Wlogout
  programs.wlogout = {
    enable = true;
    style = ''
      @import "/home/mitch/.config/wallust/wlogout-colors.css";

      * {
        font-family: "MesloLGS Nerd Font Mono", "Font Awesome 5 Free";
        background-image: none;
        transition: box-shadow 0.2s ease-in-out, background-color 0.2s ease-in-out;
      }

      window {
        background-color: @background_alpha;
      }

      button {
        color: @foreground;
        background-color: @color0_alpha;
        border: 4px solid @color4; /* Bold border */
        border-radius: 20px;
        margin: 10px; /* Small gap between buttons, major spacing handled by wrapper script */
        background-repeat: no-repeat;
        background-position: center;
        background-size: 50%; /* Make logos fill 50% of the newly constrained boxes */
      }

      button:focus, button:active, button:hover {
        background-color: @color4_alpha;
        border: 4px solid @color6;
        outline-style: none;
      }

      #lock { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png")); }
      #logout { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png")); }
      #suspend { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png")); }
      #hibernate { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png")); }
      #shutdown { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png")); }
      #reboot { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")); }
    '';
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
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
          timeout = 600; # 10 mins
          on-timeout = "if ! cat /sys/class/power_supply/*/online 2>/dev/null | grep -q 1; then brightnessctl -s set 10; fi";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 1200; # 20 mins
          on-timeout = "if ! cat /sys/class/power_supply/*/online 2>/dev/null | grep -q 1; then loginctl lock-session; fi";
        }
        {
          timeout = 1230; # 20.5 mins
          on-timeout = "if ! cat /sys/class/power_supply/*/online 2>/dev/null | grep -q 1; then hyprctl dispatch dpms off; fi";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

}
