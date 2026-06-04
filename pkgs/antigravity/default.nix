{
  pkgs ? import <nixpkgs> {},
  stdenv,
  lib,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  undmg,
}: let
  version = "2.0.11";

  # Define architectures and their specific download URLs
  sources = {
    "x86_64-linux" = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/2.0.11-6560309696135168/linux-x64/Antigravity.tar.gz";
      hash = "sha256-obK1vw3l9DBMKYl/gappy4xW6KKVcKliuVOH68cr2VE=";
    };
    "aarch64-linux" = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/2.0.11-6560309696135168/linux-arm/Antigravity.tar.gz";
      hash = lib.fakeHash;
    };
    "x86_64-darwin" = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/2.0.11-6560309696135168/darwin-x64/Antigravity.dmg";
      hash = lib.fakeHash;
    };
    "aarch64-darwin" = {
      url = "https://storage.googleapis.com/antigravity-public/antigravity-hub/2.0.11-6560309696135168/darwin-arm/Antigravity.dmg";
      hash = lib.fakeHash;
    };
  };

  srcData = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in
  stdenv.mkDerivation rec {
    pname = "antigravity";
    inherit version;

    # We use fetchurl instead of fetchzip because Darwin uses .dmg files.
    src = fetchurl {
      url = srcData.url;
      hash = srcData.hash;
    };

    nativeBuildInputs =
      [
        makeWrapper
      ]
      ++ lib.optionals stdenv.isLinux [
        autoPatchelfHook
      ]
      ++ lib.optionals stdenv.isDarwin [
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
      libX11
      libXcomposite
      libXdamage
      libXext
      libXfixes
      libXrandr
      libxcb
      libxkbfile
      libxshmfence
    ]);

    # Unpack logic differs between Linux (.tar.gz) and Darwin (.dmg)
    unpackPhase = ''
      if [[ "${stdenv.hostPlatform.system}" == *-linux ]]; then
        tar -xf $src
        cd Antigravity-linux-* || cd Antigravity* || cd .
      elif [[ "${stdenv.hostPlatform.system}" == *-darwin ]]; then
        undmg $src
      fi
    '';

    installPhase = ''
      runHook preInstall

      if [[ "${stdenv.hostPlatform.system}" == *-linux ]]; then
        mkdir -p $out/bin $out/opt/antigravity
        cp -r * $out/opt/antigravity/

        makeWrapper $out/opt/antigravity/antigravity $out/bin/antigravity \
          --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath buildInputs}" \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"

      elif [[ "${stdenv.hostPlatform.system}" == *-darwin ]]; then
        mkdir -p $out/Applications
        cp -r "Antigravity.app" $out/Applications/

        mkdir -p $out/bin
        makeWrapper "$out/Applications/Antigravity.app/Contents/MacOS/Antigravity" $out/bin/antigravity
      fi

      runHook postInstall
    '';

    meta = with lib; {
      description = "Google Antigravity IDE (Multi-Platform)";
      platforms = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    };
  }
