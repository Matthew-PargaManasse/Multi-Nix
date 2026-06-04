{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "antigravity";
  version = "1.0.0";

  # The precompiled Electron binaries downloaded by the user
  src = /home/mitch/Downloads/AntiG/Antigravity-x64;

  # We do not want to unpack an archive since the source is already an extracted directory
  dontUnpack = true;

  nativeBuildInputs = [
    pkgs.autoPatchelfHook
    pkgs.makeWrapper
  ];

  # The standard suite of libraries required by an Electron application
  buildInputs = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    curl
    dbus
    expat
    fontconfig
    freetype
    glib
    gtk3
    libdrm
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
    xorg.libxkbfile
    xorg.libxshmfence
  ];

  installPhase = ''
    # Create the installation directories in the Nix store
    mkdir -p $out/bin $out/opt/antigravity
    
    # Copy all application files to /opt/antigravity/
    cp -r $src/* $out/opt/antigravity/
    
    # Expose the primary executable via a wrapper script
    makeWrapper $out/opt/antigravity/antigravity $out/bin/antigravity \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath buildInputs}" \
      --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
  '';

  meta = with pkgs.lib; {
    description = "Antigravity IDE/App (Precompiled Electron Binary)";
    platforms = platforms.linux;
  };
}
