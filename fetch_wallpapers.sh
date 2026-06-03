#!/usr/bin/env bash

# Create the dynamic wallpaper directory
WALLPAPER_DIR="$HOME/wallpapers/dynamic"
mkdir -p "$WALLPAPER_DIR"

echo "Downloading ML4W Wallpapers..."
# Clone ML4W wallpapers to a temporary directory and move images
git clone --depth 1 https://github.com/mylinuxforwork/wallpapers.git /tmp/ml4w_wallpapers
find /tmp/ml4w_wallpapers -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) -exec cp {} "$WALLPAPER_DIR/" \;
rm -rf /tmp/ml4w_wallpapers

echo "Downloading TokyoNight Wallpapers..."
# Clone TokyoNight specific wallpapers
git clone --depth 1 https://github.com/zhichaoh/tokyo-night-wallpapers.git /tmp/tokyonight_wallpapers
find /tmp/tokyonight_wallpapers -type f \( -iname \*.jpg -o -iname \*.png -o -iname \*.jpeg \) -exec cp {} "$WALLPAPER_DIR/" \;
rm -rf /tmp/tokyonight_wallpapers

echo "Done! You now have a massive collection of dynamic wallpapers in $WALLPAPER_DIR."
echo "wpaperd will automatically rotate them every 30 minutes."
