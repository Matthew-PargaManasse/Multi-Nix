{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos/base.nix
  ];

  networking.hostName = "rpi4";

  # Bootloader setup for Raspberry Pi 4
  boot.loader.systemd-boot.enable = false; # Disable systemd-boot from base
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # Stylix (required since home/base.nix expects stylix to be available)
  stylix.enable = true;
  stylix.image = ../../wallpapers/ml4w_tokyonight.jpg;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  users.users.mitch = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager"];
  };

  users.users.mitch-daily = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager"];
  };

  users.users.mitch-embedded = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager"];
  };

  # Dummy filesystem to pass nix flake check (replace with actual blkid if installing)
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };
}
