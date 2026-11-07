{ lib
, stdenvNoCC
, fetchurl
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "bsk";
  version = "0.4.0";

  # 官方 Linux 产物是静态链接的 musl 二进制，不需要 autoPatchelfHook / FHS 环境
  src = fetchurl {
    url = "https://github.com/Tencent/BrowserSkill/releases/download/cli-v${finalAttrs.version}/bsk-v${finalAttrs.version}-x86_64-unknown-linux-musl.tar.gz";
    hash = "sha256-2KN+xJUF6LusFc8zNcgy0Sx3EY3idvgWTcrZMjyvq8U=";
  };

  # 压缩包里只有一个顶层文件 bsk，没有目录
  sourceRoot = ".";
  dontStrip = true;
  dontPatchELF = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 bsk $out/bin/bsk
    runHook postInstall
  '';

  meta = {
    description = "BrowserSkill CLI and daemon (prebuilt static musl binary)";
    homepage = "https://github.com/Tencent/BrowserSkill";
    license = lib.licenses.mit;
    mainProgram = "bsk";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
