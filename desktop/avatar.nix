{ config, pkgs, ... }:

let
  # 假设你的 config.kdl 文件与 home.nix 在同一目录
  avatar = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/images/.face";
in {
  home.file.".face".source = avatar;
}
