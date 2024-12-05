{ config, lib, pkgs, inputs, ...}:

{

      gtk = {
        enable = true;
        gtk3.extraConfig.gtk-decoration-layout = "menu:";
        theme = {
          name = "Tokyonight-Dark";
          package = pkgs.tokyo-night-gtk;
        };
        iconTheme = {
          name = "Tokyonight-Dark";
	  package = pkgs.tokyo-night-gtk;
        };
        cursorTheme = {
          name = "Bibata-Modern-Ice";
          package = pkgs.bibata-cursors;
        };
      };
}
