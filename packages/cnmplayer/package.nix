{
  lib,
  rustPlatform,
  fetchFromGitHub,
  cmake,
  pkg-config,
  makeWrapper,

  alsa-lib,
  chafa,
  dbus,
  glib,
  openssl,
  pipewire,

  # exec'd at runtime for spectrum visualization (optional upstream).
  cava,
}:

rustPlatform.buildRustPackage {
  pname = "cnmplayer";
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "professor-lee";
    repo = "CNMPlayer";
    tag = "v0.5.2";
    hash = "sha256-icO9GzboUvqDX53Kz8VMMt/FlzfvWjD/6yYVCV+Vx8U=";
  };

  cargoHash = "sha256-wC7RkB3lh0N3kbLZJf5H3NugoOF60hgCeCouQQJx5Rk=";

  nativeBuildInputs = [
    cmake
    pkg-config
    makeWrapper
    # bindgen (via pipewire-sys) needs libclang.
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    alsa-lib
    chafa
    dbus
    glib
    openssl
    pipewire
  ];

  postInstall = ''
    wrapProgram $out/bin/cnmplayer \
      --prefix PATH : "${lib.makeBinPath [ cava ]}" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [ chafa ]}"
  '';

  meta = {
    description = "TUI Netease Cloud Music Player with audio visualization";
    homepage = "https://github.com/professor-lee/CNMPlayer";
    license = lib.licenses.agpl3Only;
    mainProgram = "cnmplayer";
    platforms = [ "x86_64-linux" ];
  };
}
