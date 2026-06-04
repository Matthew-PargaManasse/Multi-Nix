# This is a PLACEHOLDER file!
# When you build your new desktop, boot from a NixOS Live USB, partition the drive,
# and run `nixos-generate-config --root /mnt`.
# Then REPLACE this file with the `hardware-configuration.nix` that command generates.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "placeholder";
    fsType = "ext4";
  };

  swapDevices = [];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
