{ config, pkgs, ... }:

{
  imports = [
    ../../modules/nixos/base.nix
  ];

  networking.hostName = "rpi4";

  # Bootloader setup for Raspberry Pi 4
  boot.loader.systemd-boot.enable = false; # Disable systemd-boot from base
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  users.users.mitch = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  
  users.users.mitch-daily = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  
  users.users.mitch-embedded = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
}
