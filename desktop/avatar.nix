{ config, pkgs, ... }:

let
  # 假设你的 config.kdl 文件与 home.nix 在同一目录
  avatar = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/images/.face";
in {
  home.file.".face".source = avatar;
}
