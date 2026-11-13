{ config, ... }:
{

programs.qtengine = {
  enable = true;
  config = {
    theme = {
      colorScheme = "${config.users.users.FuranYuki.home}/.local/share/color-schemes/noctalia.colors";
      #iconTheme = "breeze-dark";
      style = "darkly";
    };
    misc.singleClickActivate = false;
  };
};

}
