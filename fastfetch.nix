{ config, pkks, ... }:

let
  # 假设你的 config.kdl 文件与 home.nix 在同一目录
  configFile = ./config.jsonc;
  Reimu = ./Reimu.png;
in {
  xdg.configFile = {
    "fastfetch/config.jsonc".source = configFile;
    "fastfetch/Reimu.png".source = Reimu;
  };
}