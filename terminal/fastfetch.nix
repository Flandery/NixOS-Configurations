{ config, pkgs, ... }:

let
  # 假设你的 config.kdl 文件与 home.nix 在同一目录
  configFile = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/dotfiles/fastfetch/config.jsonc";
  Reimu = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/dotfiles/fastfetch/Reimu.png";
  Momoko = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/images/tianzi5.png";
in {
  xdg.configFile = {
    "fastfetch/config.jsonc".source = configFile;
    "fastfetch/Reimu.png".source = Reimu;
    "fastfetch/Momoko.png".source = Momoko;
  };
}
