{ config, pkgs, ... }:

let
  configFile = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/dotfiles/umbriel/config.toml";
in {
 xdg.configFile = {
  "umbriel/config.toml".source = configFile;
 };
}