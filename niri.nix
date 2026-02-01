{ config, pkgs, ... }:

let
  configFile = ./config.kdl;
in {
 xdg.configFile = {
  "niri/config.kdl".source = configFile;
 };
} 