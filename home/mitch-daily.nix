{ config, pkgs, inputs, ... }:

{
  imports = [
    ./base.nix
    ./common/brave.nix
  ];

  home.username = "mitch-daily";
  home.homeDirectory = "/home/mitch-daily";

  home.packages = with pkgs; [
    # Privacy and Comms
    protonmail-bridge
    protonvpn-gui
    signal-desktop
    element-desktop
    slack
    thunderbird
    
    # Desktop Apps
    gimp
    kdePackages.dolphin
  ];
}
