{ config, pkgs, ... }:

let
  configFile = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/config.kdl";
  animationsFile = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/animations.kdl";
in {
 xdg.configFile = {
  "niri/config.kdl".source = configFile;
  "niri/animations.kdl".source = animationsFile;
 };
} 