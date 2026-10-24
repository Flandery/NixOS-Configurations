{ config, ... }:
{

programs.qtengine = {
  enable = true;
  config = {
    theme = {
      colorScheme = "${config.users.users.Flandery.home}/.local/share/color-schemes/noctalia.colors";
      #iconTheme = "breeze-dark";
      style = "darkly";
    };
  };
};

}
