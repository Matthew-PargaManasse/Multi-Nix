{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos/base.nix
    ../../modules/nixos/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  # Define system users
  users.users.mitch = {
    isNormalUser = true;
    description = "mitch";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
  };

  users.users.mitch-daily = {
    isNormalUser = true;
    description = "Daily Tasks and Privacy";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel"];
  };

  users.users.mitch-embedded = {
    isNormalUser = true;
    description = "Embedded Systems Exploitation";
    shell = pkgs.zsh;
    extraGroups = ["networkmanager" "wheel" "dialout" "plugdev"];
  };

  # You can place desktop-specific hardware quirks here
  # services.xserver.videoDrivers = [ "nvidia" ]; # Uncomment if using an Nvidia GPU!
}
