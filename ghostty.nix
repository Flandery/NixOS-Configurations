{ config, pkks, ... }:

let
  # 假设你的 config.kdl 文件与 home.nix 在同一目录
  configFile = ./config-ghostty;
in {
  xdg.configFile = {
    "ghostty/config".source = configFile;
  };
}