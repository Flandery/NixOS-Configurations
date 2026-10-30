{ config, pkgs, ... }:

let
  configFile = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/dotfiles/umbriel/config.toml";
  #animationsFile = config.lib.file.mkOutOfStoreSymlink "${config.configDir}/dotfiles/umbriel/animations.toml";
in {
 xdg.configFile = {
  "umbriel/config.toml".source = configFile;
  #"umbriel/animations.toml".source = animationsFile;
 };
}
