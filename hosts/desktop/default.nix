{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos/desktop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";

  # You can place desktop-specific hardware quirks here
  # services.xserver.videoDrivers = [ "nvidia" ]; # Uncomment if using an Nvidia GPU!
}
