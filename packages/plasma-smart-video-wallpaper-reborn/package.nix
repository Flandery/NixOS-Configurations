{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  gettext,
  kdePackages,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "plasma-smart-video-wallpaper-reborn";
  version = "2.15.0";

  src = fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "plasma-smart-video-wallpaper-reborn";
    tag = "v${finalAttrs.version}";
    hash = "sha256-LgIe+ytAf6AHSpgOUeqFRWOtx+uV71FZixMQKY+iJWM=";
  };

  nativeBuildInputs = [
    cmake
    ninja
    gettext
    kdePackages.extra-cmake-modules
  ];

  # 纯 QML 模块/壁纸包，无二进制需要包装
  dontWrapQtApps = true;

  buildInputs = [
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.ki18n
    kdePackages.libplasma
    kdePackages.knighttime
    kdePackages.kcmutils
  ];

  postInstall = ''
    chmod +x $out/share/plasma/wallpapers/luisbocanegra.smart.video.wallpaper.reborn/contents/ui/tools/gdbus_get_signal.sh
  '';

  meta = {
    description = "Plasma 6 wallpaper plugin to play videos on your desktop/lock screen";
    homepage = "https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn";
    license = lib.licenses.gpl2Plus;
    platforms = lib.platforms.linux;
  };
})