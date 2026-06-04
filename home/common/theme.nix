{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-decoration-layout = "menu:";
    # theme is managed by Stylix (dynamic wallpaper-based colors)
    iconTheme = {
      name = lib.mkForce "Tokyonight-Dark";
      package = pkgs.tokyo-night-gtk;
    };
    cursorTheme = {
      name = lib.mkForce "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
  };
}
