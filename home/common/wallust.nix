{ pkgs, ... }: {
  home.packages = with pkgs; [
    wallust
    awww
  ];

  home.file.".config/wallust/wallust.toml".text = ''
    backend = "fastresize"
    color_space = "lch"
    palette = "dark16"
    check_contrast = true
    
    [templates.waybar]
    template = "waybar.css"
    target = "~/.config/wallust/waybar-colors.css"
    
    [templates.wlogout]
    template = "wlogout.css"
    target = "~/.config/wallust/wlogout-colors.css"
    
    [templates.hyprland]
    template = "hyprland.conf"
    target = "~/.config/wallust/hyprland-colors.conf"
    
    [templates.rofi]
    template = "rofi.rasi"
    target = "~/.config/wallust/rofi-colors.rasi"

    [templates.gtk4]
    template = "gtk4.css"
    target = "~/.config/wallust/gtk-colors.css"
  '';

  home.file.".config/wallust/templates/waybar.css".text = ''
    @define-color background {{background}};
    @define-color foreground {{foreground}};
    @define-color color0 {{color0}};
    @define-color color1 {{color1}};
    @define-color color2 {{color2}};
    @define-color color3 {{color3}};
    @define-color color4 {{color4}};
    @define-color color5 {{color5}};
    @define-color color6 {{color6}};
    @define-color color7 {{color7}};
    @define-color color8 {{color8}};
    @define-color color9 {{color9}};
    @define-color color10 {{color10}};
    @define-color color11 {{color11}};
    @define-color color12 {{color12}};
    @define-color color13 {{color13}};
    @define-color color14 {{color14}};
    @define-color color15 {{color15}};
  '';

  home.file.".config/wallust/templates/wlogout.css".text = ''
    @define-color background_alpha rgba({{background | rgb}}, 0.6);
    @define-color foreground {{foreground}};
    @define-color color0_alpha rgba({{color0 | rgb}}, 0.6);
    @define-color color4_alpha rgba({{color4 | rgb}}, 0.4);
    @define-color color4 {{color4}};
    @define-color color6 {{color6}};
  '';

  home.file.".config/wallust/templates/hyprland.conf".text = ''
    $background = rgb({{background | strip}})
    $foreground = rgb({{foreground | strip}})
    $color0 = rgb({{color0 | strip}})
    $color1 = rgb({{color1 | strip}})
    $color2 = rgb({{color2 | strip}})
    $color3 = rgb({{color3 | strip}})
    $color4 = rgb({{color4 | strip}})
    $color5 = rgb({{color5 | strip}})

    general {
      col.active_border = $color2 $color4 45deg
      col.inactive_border = $background
    }
  '';

  home.file.".config/wallust/templates/rofi.rasi".text = ''
    * {
        background:                  rgba({{background | rgb}}, 0.8);
        background-alt:              rgba({{color0 | rgb}}, 0.6);
        foreground:                  {{foreground}};
        selected:                    {{color4}};
        active:                      {{color2}};
        urgent:                      {{color1}};
    }
  '';

  home.file.".config/wallust/templates/gtk4.css".text = ''
    @define-color window_bg_color rgba({{background | rgb}}, 0.6);
    @define-color window_fg_color {{foreground}};
    @define-color view_bg_color rgba({{background | rgb}}, 0.5);
    @define-color view_fg_color {{foreground}};
    @define-color headerbar_bg_color rgba({{background | rgb}}, 0.75);
    @define-color headerbar_fg_color {{foreground}};
    @define-color headerbar_backdrop_color rgba({{background | rgb}}, 0.75);
    @define-color card_bg_color rgba({{color0 | rgb}}, 0.8);
    @define-color card_fg_color {{foreground}};
    @define-color card_shade_color rgba({{color0 | rgb}}, 0.5);
    @define-color popover_bg_color rgba({{background | rgb}}, 0.95);
    @define-color accent_color {{color4}};
    @define-color accent_bg_color {{color4}};
    @define-color accent_fg_color {{background}};
    @define-color destructive_color {{color1}};
    @define-color destructive_bg_color {{color1}};
    @define-color destructive_fg_color {{background}};
    @define-color success_color {{color2}};
    @define-color success_bg_color {{color2}};
    @define-color success_fg_color {{background}};
    @define-color warning_color {{color3}};
    @define-color warning_bg_color {{color3}};
    @define-color warning_fg_color {{background}};
    @define-color error_color {{color1}};
    @define-color error_bg_color {{color1}};
    @define-color error_fg_color {{background}};

    window {
        background-color: @window_bg_color;
    }

    .navigation-sidebar, .sidebar, placessidebar {
        background-color: rgba({{background | rgb}}, 0.85);
    }
  '';

  home.file.".config/rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      display-drun: " Apps";
      display-run: " Run";
      display-window: " Windows";
      drun-display-format: "{icon} {name}";
      font: "Aptos 14";
    }
    @theme "/home/mitch/.config/rofi/theme.rasi"
  '';

  home.file.".config/rofi/theme.rasi".text = ''
    @import "/home/mitch/.config/wallust/rofi-colors.rasi"

    window {
        width: 45%;
        border-radius: 12px;
        background-color: var(background);
        border: 2px;
        border-color: var(selected);
        padding: 20px;
    }

    mainbox {
        background-color: transparent;
        spacing: 15px;
    }

    inputbar {
        background-color: var(background-alt);
        border-radius: 8px;
        padding: 12px;
        spacing: 10px;
        text-color: var(foreground);
    }

    entry {
        background-color: transparent;
        text-color: var(foreground);
        placeholder: "Search...";
        placeholder-color: inherit;
    }

    prompt {
        background-color: transparent;
        text-color: var(foreground);
        font: "Aptos Bold 14";
    }

    listview {
        background-color: transparent;
        lines: 8;
        spacing: 8px;
        scrollbar: false;
    }

    element {
        background-color: transparent;
        padding: 10px;
        border-radius: 8px;
        text-color: var(foreground);
    }

    element selected {
        background-color: var(selected);
        text-color: var(background);
    }

    element-text {
        background-color: transparent;
        text-color: inherit;
        vertical-align: 0.5;
    }

    element-icon {
        background-color: transparent;
        size: 24px;
        padding: 0 10px 0 0;
    }
  '';

  home.file.".config/hypr/wallpaper-daemon.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Initialize awww if not running
      awww query || awww-daemon &
      sleep 1

      while true; do
        # Pick random wallpaper
        WALLPAPER=$(find ~/wallpapers -type f | shuf -n 1)
        
        # Apply wallpaper with awww
        awww img "$WALLPAPER" --transition-type wipe --transition-duration 2
        
        # Generate colors with wallust
        wallust run "$WALLPAPER"
        
        # Restart Waybar to apply new colors safely
        killall .waybar-wrapped waybar || true
        waybar &
        
        # Force Hyprland to reload config to pick up new colors
        hyprctl reload
        
        # Sleep for 30 minutes
        sleep 1800
      done
    '';
  };
}
