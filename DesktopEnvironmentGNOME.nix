{ config, lib, pkgs, inputs, ... }:
{

#图形界面
 services.displayManager.gdm.enable = true;
 services.desktopManager.gnome.enable = true;
 nixpkgs.overlays = [ inputs.niri.overlays.niri ];
 programs.niri.package = pkgs.niri-unstable;
 programs.niri.enable = true;  # 启用Niri Wayland合成器（作为GNOME的替代或补充）
 #services.xserver.enable = true;
 programs.hyprland.enable = true;

environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.arc-menu
    gnomeExtensions.dash-to-dock
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.gsconnect
    gnomeExtensions.coverflow-alt-tab
    gnomeExtensions.desktop-icons-ng-ding
    gnomeExtensions.dash-to-panel
    gnomeExtensions.background-logo
    gnomeExtensions.logo-menu
    gnomeExtensions.steal-my-focus-window
    gnomeExtensions.fuzzy-application-search
    gnomeExtensions.tiling-shell
    gnomeExtensions.vitals
    gnomeExtensions.desktop-cube
    gnomeExtensions.rounded-window-corners-reborn
    gnomeExtensions.app-icons-taskbar
    gnomeExtensions.tiling-assistant
    gnomeExtensions.highlight-focus
    gnomeExtensions.burn-my-windows
    gnomeExtensions.forge
    gnomeExtensions.app-menu-is-back
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.compiz-alike-magic-lamp-effect
    #gnomeExtensions.wallhub
    #gnomeExtensions.custom-window-controls
    dconf-editor
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.search-light
    gnomeExtensions.open-bar
  ];
 #Niri Config
 security.polkit.enable = true; # polkit
 services.gnome.gnome-keyring.enable = true; # secret service
 security.pam.services.swaylock = {};
 xdg.portal.config.niri = {
  "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
 };

 #DMS-SHELL
 programs.dms-shell = {
  enable = true;

  systemd = {
    enable = false;             # Systemd service for auto-start
    restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
  };
  
  # Core features
  enableSystemMonitoring = true;     # System monitoring widgets (dgop)
  enableVPN = true;                  # VPN management widget
  enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
  enableAudioWavelength = true;      # Audio visualizer (cava)
  enableCalendarEvents = true;       # Calendar integration (khal)
  enableClipboardPaste = true;       # Pasting from the clipboard history (wtype)
 };

}
