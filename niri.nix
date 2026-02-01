{ config, pkgs, ... }:

{

 home.file = {
   "./config.kdl".source = ~/.config/niri/config.kdl
  };

}
