{
  lib,
  stdenvNoCC,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  bintools,
  xdg-utils,

  alsa-lib,
  at-spi2-atk,
  at-spi2-core,
  atk,
  cairo,
  cups,
  dbus,
  expat,
  gcc-unwrapped,
  glib,
  gsettings-desktop-schemas,
  gtk3,
  libX11,
  libxcb,
  libXcomposite,
  libXdamage,
  libXext,
  libXfixes,
  libXrandr,
  libxkbcommon,
  libXScrnSaver,
  libXtst,
  libgbm,
  nspr,
  nss,
  pango,
  systemdLibs,

  # dlopen()ed at runtime, so not discoverable from DT_NEEDED; list them
  # here to put them on the RUNPATH.
  libayatana-appindicator,
  libglvnd,
  libnotify,
  libpulseaudio,
  libsecret,
  libXcursor,
  pipewire,
  wayland,

  # Needed for XDG_ICON_DIRS and GSETTINGS_SCHEMAS_PATH.
  adwaita-icon-theme,
}:

let
  version = "3.11.2";

  platform = {
    x86_64-linux = "linux-x64";
    aarch64-linux = "linux-arm64";
  }.${stdenvNoCC.hostPlatform.system};

  src = fetchurl {
    url = "https://cdn-zcode.z.ai/zcode/electron/releases/${version}/${platform}/ZCode-${version}-${platform}.deb";
    hash = "sha256-fRO4OGMTAs9h4bgEDLZ/NJ7CNWZ5WJfxdGQyxcXXfVs=";
  };

  desktopItem = makeDesktopItem {
    name = "zcode";
    desktopName = "ZCode";
    comment = "ZCode Desktop App";
    exec = "zcode %U";
    icon = "zcode";
    categories = [ "Development" ];
    startupWMClass = "ZCode";
    mimeTypes = [ "x-scheme-handler/zcode" ];
  };

  buildInputs = [
    adwaita-icon-theme
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    gcc-unwrapped.lib
    glib
    gsettings-desktop-schemas
    gtk3
    libgbm
    libX11
    libxcb
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    libxkbcommon
    libXScrnSaver
    libXtst
    nspr
    nss
    pango
    systemdLibs
  ];

  runtimeDependencies = [
    libayatana-appindicator
    libglvnd
    libnotify
    libpulseaudio
    libsecret
    libXcursor
    pipewire
    wayland
  ];
in
stdenvNoCC.mkDerivation {
  pname = "zcode";
  inherit version src;

  nativeBuildInputs = [
    autoPatchelfHook
    bintools
    copyDesktopItems
    makeWrapper
  ];

  inherit buildInputs;
  desktopItems = [ desktopItem ];

  unpackPhase = ''
    runHook preUnpack
    ar x $src
    tar xf data.tar.xz
    runHook postUnpack
  '';

  # Keep the upstream opt/ZCode layout so bundled libs (e.g. libffmpeg.so)
  # resolve next to the main binary.
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib $out/bin $out/share
    cp -a opt/ZCode $out/lib/ZCode
    cp -a usr/share/icons $out/share/icons

    chmod +x $out/lib/ZCode/zcode

    # dlopen()ed at runtime, so not discoverable from DT_NEEDED; put them
    # on the RUNPATH.
    patchelf --add-rpath \
      "$(patchelf --print-rpath $out/lib/ZCode/zcode):${lib.makeLibraryPath runtimeDependencies}" \
      $out/lib/ZCode/zcode

    makeWrapper "$out/lib/ZCode/zcode" "$out/bin/zcode" \
      --suffix PATH : "${lib.makeBinPath [ xdg-utils ]}" \
      --prefix XDG_DATA_DIRS : "$XDG_ICON_DIRS:$GSETTINGS_SCHEMAS_PATH" \
      --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations --enable-wayland-ime=true}}"

    runHook postInstall
  '';

  meta = {
    description = "Agentic development environment (ADE) by Z.ai";
    homepage = "https://zcode.z.ai";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "zcode";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}