# Migrating Multi-Nix to a New Computer

When you move your NixOS configuration to a new computer, you **cannot** just copy the files and run `nixos-rebuild` immediately. The hardware on the new computer (disk UUIDs, kernel modules, networking cards) will be completely different from your old one. If you copy the old `hardware-configuration.nix`, the new computer will fail to boot because it will look for the old hard drive's UUIDs (especially if you use LUKS encryption).

Follow these steps to safely migrate this `Multi-Nix` configuration to a new machine.

## 1. Prepare the New Computer
1. Flash a USB drive with the latest NixOS Live Graphical ISO.
2. Boot the new computer from the USB drive.
3. Open a terminal and partition your new SSD using `fdisk`, `parted`, or `cfdisk`.
   - Create a Boot partition (FAT32, typically 512MB).
   - Create a Root partition (ext4 or btrfs).
4. **(Optional)** If you want LUKS encryption on the new drive, set it up now:
   ```bash
   cryptsetup luksFormat /dev/nvme0n1p2
   cryptsetup open /dev/nvme0n1p2 cryptroot
   mkfs.ext4 /dev/mapper/cryptroot
   ```
5. Mount your partitions:
   ```bash
   mount /dev/mapper/cryptroot /mnt
   mkdir -p /mnt/boot
   mount /dev/nvme0n1p1 /mnt/boot
   ```

## 2. Generate New Hardware Config
With the new partitions mounted, you need to generate a configuration specific to this new hardware's UUIDs:
```bash
nixos-generate-config --root /mnt
```
This will create two files in `/mnt/etc/nixos/`: `configuration.nix` and `hardware-configuration.nix`.

## 3. Copy Your Multi-Nix Flake
1. Copy your entire `Multi-Nix` folder from a backup drive (or Git) into the new computer (e.g., to `/mnt/home/mitch/Multi-Nix`).
2. Delete the old `hosts/laptop/hardware-configuration.nix` in the Multi-Nix folder.
3. Copy the newly generated hardware configuration into your flake:
   ```bash
   cp /mnt/etc/nixos/hardware-configuration.nix /mnt/home/mitch/Multi-Nix/hosts/laptop/
   ```

## 4. Rebuild and Install
Now you can install NixOS using your flake!
Change your directory to the Multi-Nix folder and run:
```bash
nixos-install --flake .#laptop
```
Once the installation finishes, you will be prompted for a root password. Set it, then `reboot`.

## Summary
By following these steps, you are telling NixOS to use all of your custom Hyprland, ZSH, and User configurations from the flake, but replacing the underlying hardware instructions so it boots perfectly on the new SSD!
