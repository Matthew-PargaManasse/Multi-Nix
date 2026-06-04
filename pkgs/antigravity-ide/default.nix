{ pkgs ? import <nixpkgs> {}, stdenv, lib, fetchurl, autoPatchelfHook, makeWrapper, undmg }:

let
  version = "2.0.4";

  # Define architectures and their specific download URLs for Antigravity IDE
  sources = {
    "x86_64-linux" = {
      url = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/2.0.4-6381998290370560/linux-x64/Antigravity%20IDE.tar.gz";
      hash = lib.fakeHash;
    };
    "aarch64-linux" = {
      url = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/2.0.4-6381998290370560/linux-arm/Antigravity%20IDE.tar.gz";
      hash = lib.fakeHash;
    };
    "x86_64-darwin" = {
      url = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/2.0.4-6381998290370560/darwin-x64/Antigravity%20IDE.dmg";
      hash = lib.fakeHash;
    };
    "aarch64-darwin" = {
      url = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/2.0.4-6381998290370560/darwin-arm/Antigravity%20IDE.dmg";
      hash = lib.fakeHash;
    };
  };

  srcData = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

in
stdenv.mkDerivation rec {
  pname = "antigravity-ide";
  inherit version;

  src = fetchurl {
    url = srcData.url;
    hash = srcData.hash;
  };

  nativeBuildInputs = [
    makeWrapper
  ] ++ lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ] ++ lib.optionals stdenv.isDarwin [
    undmg
  ];

  buildInputs = lib.optionals stdenv.isLinux (with pkgs; [
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
  ]);

  unpackPhase = ''
    if [[ "${stdenv.hostPlatform.system}" == *-linux ]]; then
      tar -xf $src
      # The extracted folder might have spaces or differ slightly
      cd "Antigravity IDE"* || cd Antigravity* || cd .
    elif [[ "${stdenv.hostPlatform.system}" == *-darwin ]]; then
      undmg $src
    fi
  '';

  installPhase = ''
    runHook preInstall

    if [[ "${stdenv.hostPlatform.system}" == *-linux ]]; then
      mkdir -p $out/bin $out/opt/antigravity-ide
      cp -r * $out/opt/antigravity-ide/
      
      # The binary might be "Antigravity IDE" or "antigravity-ide"
      # We find the main executable in the root of the opt directory
      if [ -f "$out/opt/antigravity-ide/Antigravity IDE" ]; then
        EXEC_TARGET="$out/opt/antigravity-ide/Antigravity IDE"
      elif [ -f "$out/opt/antigravity-ide/antigravity-ide" ]; then
        EXEC_TARGET="$out/opt/antigravity-ide/antigravity-ide"
      elif [ -f "$out/opt/antigravity-ide/antigravity" ]; then
        EXEC_TARGET="$out/opt/antigravity-ide/antigravity"
      else
        echo "Could not find main executable!"
        exit 1
      fi

      makeWrapper "$EXEC_TARGET" $out/bin/antigravity-ide \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
        --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"

    elif [[ "${stdenv.hostPlatform.system}" == *-darwin ]]; then
      mkdir -p $out/Applications
      cp -r "Antigravity IDE.app" $out/Applications/ 2>/dev/null || cp -r "Antigravity.app" $out/Applications/
      
      mkdir -p $out/bin
      if [ -f "$out/Applications/Antigravity IDE.app/Contents/MacOS/Antigravity IDE" ]; then
        makeWrapper "$out/Applications/Antigravity IDE.app/Contents/MacOS/Antigravity IDE" $out/bin/antigravity-ide
      else
        makeWrapper "$out/Applications/Antigravity.app/Contents/MacOS/Antigravity" $out/bin/antigravity-ide
      fi
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "Google Antigravity IDE (Multi-Platform)";
    platforms = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
  };
}
