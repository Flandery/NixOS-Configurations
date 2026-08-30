{ config, lib, pkgs, inputs, ... }:
{

# Enable Plasma 
  services = {
    desktopManager.plasma6.enable = true;

  # Default display manager for Plasma
    displayManager.plasma-login-manager.enable = true;

  # Optionally enable xserver
  # xserver.enable = true;
  };
  nixpkgs.overlays = [ inputs.niri.overlays.default ];
  programs.niri.package = pkgs.niri;
  programs.niri.enable = true;  # 启用Niri Wayland合成器（作为GNOME的替代或补充）
  programs.hyprland.enable = true;
  services.displayManager.defaultSession = lib.mkForce null;
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
