{ config, pkgs, ... }:

let
  # 假设你的 config.kdl 文件与 home.nix 在同一目录
  configFile = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/dotfiles/ghostty/config-ghostty";
in {
  xdg.configFile = {
    "ghostty/config".source = configFile;
  };
}
