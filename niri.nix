{ config, pkgs, ... }:

let
  configFile = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/config.kdl";
  animationsFile = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/animations.kdl";
  effectsFile = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/niri_effects.kdl";
  rulesFile = config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/niri_rules.kdl";
in {
 xdg.configFile = {
  "niri/config.kdl".source = configFile;
  "niri/animations.kdl".source = animationsFile;
  "niri/niri_effects.kdl".source = effectsFile;
  "niri/niri_rules.kdl".source = rulesFile;
 };
} 
