{ config, lib, pkgs, inputs, ... }:
{

#启用wm
nixpkgs.overlays = [ inputs.niri.overlays.default ];
programs.niri.package = pkgs.niri;
programs.niri.enable = true;
programs.hyprland.enable = true;
programs.umbriel.enable = true;

#Niri配置
security.polkit.enable = true; # polkit
services.gnome.gnome-keyring.enable = true; # secret service
security.pam.services.swaylock = {};
xdg.portal.config.niri = {
  "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
};

#DM配置
services.displayManager.noctalia-greeter = {
  enable = true;
  settings = {
    cursor = {
      theme = "Bibata-Modern-Ice";
      size = 24;
      path = pkgs.bibata-cursors;
    };
    keyboard.numlock = true;
  };
};

#其他配置
xdg.mime.defaultApplications."inode/directory" = "org.kde.dolphin.desktop";

#wm附加
programs.dms-shell = {
  enable = true;
  systemd = {
    enable = false;             # Systemd service for auto-start
    restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
  };
};

#相关软件包
environment.systemPackages = with pkgs; [
  inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
];

}
