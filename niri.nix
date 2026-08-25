{ config, pkgs, ... }:

let
  configFile = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/config.kdl";
in {
 xdg.configFile = {
  "niri/config.kdl".source = configFile;
 };
} 