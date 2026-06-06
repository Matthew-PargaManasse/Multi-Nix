{ pkgs, ... }: {
  home.packages = with pkgs; [
    wallust
    awww
  ];

  home.file.".config/wallust/wallust.toml".text = ''
    backend = "fastresize"
    color_space = "lab"
    palette = "dark16"
    
    [templates]
    waybar = {
      template = "waybar.css"
      target = "~/.config/wallust/waybar-colors.css"
    }
    wlogout = {
      template = "wlogout.css"
      target = "~/.config/wallust/wlogout-colors.css"
    }
    hyprland = {
      template = "hyprland.conf"
      target = "~/.config/wallust/hyprland-colors.conf"
    }
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
    @define-color background {{background}};
    @define-color foreground {{foreground}};
    @define-color color0 {{color0}};
    @define-color color1 {{color1}};
    @define-color color2 {{color2}};
    @define-color color3 {{color3}};
    @define-color color4 {{color4}};
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
        
        # Reload Waybar to apply new colors
        killall -SIGUSR2 waybar
        
        # Force Hyprland to reload config to pick up new colors
        hyprctl reload
        
        # Sleep for 30 minutes
        sleep 1800
      done
    '';
  };
}
