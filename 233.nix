{ config, lib, pkgs, inputs, ... }:
{
 users.users.Flandery = {
     isNormalUser = true;
     extraGroups = [ "wheel" "gamemode" "networkmanager" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
   #     tree
     ];
   };
 networking.hostName = "FlanderyNixOS"; # Define your hostname.
 time.timeZone = "Asia/Shanghai";
 environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    bash
    neovim
    prismlauncher
    vscode
    mission-center
    qq
    git
    neofetch
    fastfetch
    starship
    yazi
    kitty
    fuzzel
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    xwayland-satellite
    gnome-tweaks
    refine
    mangohud
    mangojuice
    #vimPlugins.nvim-treesitter-parsers.cmake
    lutris
    gcc
    splayer
    btop
    go-musicfox
#    vimPlugins.nvim-treesitter
#    vimPlugins.nvim-treesitter-textobjects
    cava
    obs-studio
#    vimPlugins.lazy-nvim
#    polkit_gnome
#    xdg-desktop-portal-gnome
    btrfs-progs
    wechat
    telegram-desktop
    libreoffice
    wl-clipboard
#    power-profiles-daemon
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
    gnomeExtensions.wallhub
    #gnomeExtensions.custom-window-controls
    dconf-editor
    ghostty
    protonplus
    # ...
    # support both 32- and 64-bit applications
    wineWow64Packages.stable
    # support 32-bit only (read above!)
    wine
    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })
    # support 64-bit only
    wine64
    # wine-staging (version with experimental features)
    wineWow64Packages.staging
    # winetricks (all versions)
    winetricks
    # native wayland support (unstable)
    wineWow64Packages.waylandFull
    # ... maybe other stuff
    umu-launcher
    termius
    breeze-hacked-cursor-theme
    kdePackages.breeze-gtk
    layan-cursors
    kazumi
    btrfs-assistant
#    upscaler
    activate-linux
    discord
    #iptables
    #iptables-legacy
    networkmanagerapplet
    dnsmasq
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.search-light
    gnomeExtensions.open-bar
  ];
# services = {
#  desktopManager.plasma6.enable = true;
#  displayManager.sddm.enable = true;
#  displayManager.sddm.wayland.enable = true;
# };

#图形界面
 services.displayManager.gdm.enable = true;
 services.desktopManager.gnome.enable = true;
 programs.niri.enable = true;  # 启用Niri Wayland合成器（作为GNOME的替代或补充）
 services.xserver.enable = true;

# Enable sound with pipewire.
 services.pulseaudio.enable = false;
 security.rtkit.enable = true;
 services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
};

#nix-channels源
 nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"  # 添加中科大镜像源
      "https://cache.nixos.org/"  # 默认官方缓存
    ];
    experimental-features = [ "nix-command" "flakes" ];  # 启用实验性功能：nix命令增强和flakes支持
  }; 
 
#杂项
 nixpkgs.config.allowUnfree = true;
 programs.clash-verge.enable = true;
 programs.clash-verge.tunMode = true;
 programs.firefox.enable = true;
 programs.fish.enable = true;
 programs.clash-verge.serviceMode = true;
 networking.firewall.enable = false;
 users.defaultUserShell = pkgs.fish;
 programs.direnv.enable = true;
 programs.gamemode.enable = true;
 programs.gamemode.settings = {
  general = {
    renice = 10;
  };
 };

#zram
 zramSwap = {
      enable = true;
      memoryPercent = 100;
      algorithm = "zstd";
      priority = 10;
 }; # Creates a zram block device and uses it as a swap device


# 启用自动垃圾收集
# ......
# do not need to keep too much generations
boot.loader.systemd-boot.configurationLimit = 10;
# boot.loader.grub.configurationLimit = 10;
# do garbage collection weekly to keep disk usage low
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 7d";
};
# Optimise storage
# you can also optimise the store manually via:
#    nix-store --optimise
# https://nixos.org/manual/nix/stable/command-ref/conf-file.html#conf-auto-optimise-store
nix.settings.auto-optimise-store = true;
# nix.gc.automatic = true;
# 设置清理选项：删除超过7天的旧世代
# nix.gc.options = "--delete-older-than 7d";
# nix.gc.dates = "weekly";

 # 启用必要的字体服务
 fonts.enableDefaultPackages = true; # 可选项：启用一些基础字体以获得基本的Unicode字符覆盖[citation:1]
 fonts.fontconfig.enable = true;
 fonts = {
  packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans    # 思源黑体 (无衬线)
    noto-fonts-cjk-serif   # 思源宋体 (衬线)
    nerd-fonts.fira-code
    ];
  fontconfig = {
    defaultFonts = {
     };
   };
 };

# 启用 Fcitx5 输入法
 i18n.inputMethod = {
   enable = true;
   type = "fcitx5";
   # 配置要使用的输入法引擎
   fcitx5.addons = with pkgs; [
     qt6Packages.fcitx5-chinese-addons  # 中文输入引擎，包含拼音、双拼等
     fcitx5-fluent # 主题皮肤
      (fcitx5-rime.override {
        rimeDataPkgs = [
          pkgs.rime-ice
	  ];
	 })
     #fcitx5-rime            # Rime 输入法（可选）
     # 添加其他你需要的引擎，例如：
     # fcitx5-mozc          # 日文输入法
     # fcitx5-hangul        # 韩文输入法
   ];
   # **关键：为 Wayland 环境启用 Wayland 前端支持**
   fcitx5.waylandFrontend = true;
 };

# 设置系统的中文环境
 i18n = {
#   defaultLocale = "zh_CN.UTF-8";
#   extraLocaleSettings = {
#     LC_ADDRESS = "zh_CN.UTF-8";
#     LC_IDENTIFICATION = "zh_CN.UTF-8";
#     LC_MEASUREMENT = "zh_CN.UTF-8";
#     LC_MONETARY = "zh_CN.UTF-8";
#     LC_NAME = "zh_CN.UTF-8";
#     LC_NUMERIC = "zh_CN.UTF-8";
#     LC_PAPER = "zh_CN.UTF-8";
#     LC_TELEPHONE = "zh_CN.UTF-8";
#     LC_TIME = "zh_CN.UTF-8";
#  };
 supportedLocales = [ "zh_CN.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" ];
 };

#环境变量
# 可选：为 GTK/Qt 程序设置环境变量（启用Wayland前端后，部分变量可能被覆盖[citation:3]）
 environment.sessionVariables = {
   # 如果你只使用X11应用，可能需要保留这些[citation:3]
   # GTK_IM_MODULE = "fcitx";
   # QT_IM_MODULE = "fcitx";
   XMODIFIERS = "@im=fcitx";
 };
 environment.variables = {
	EDITOR= "vim";
	QT_QPA_PLATFORMTHEME = "gtk3";
	QS_ICON_THEME = "Adwaita";
 };


# 对于NVIDIA显卡用户，硬件驱动配置通常是必须的
# hardware.nvidia.modesetting.enable = true;
# services.xserver.videoDrivers = [ "nvidia" ];
#GPU Drivers

#Power Settings
 services.power-profiles-daemon.enable = true;
 services.upower.enable = true;

#Niri Config
 security.polkit.enable = true; # polkit
 services.gnome.gnome-keyring.enable = true; # secret service
 security.pam.services.swaylock = {};
 xdg.portal.config.niri = {
  "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # or "kde"
 };

#GPU Settings
 hardware.graphics = {
  enable = true;
  enable32Bit = true;
 };

#Waydroid
 virtualisation.waydroid.enable = true;

#Steam
 programs.gamescope.enable = true;
 programs.steam = {
  enable = true; # Master switch, already covered in installation
  remotePlay.openFirewall = true;  # For Steam Remote Play
  dedicatedServer.openFirewall = true; # For Source Dedicated Server hosting
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  # Other general flags if available can be set here.
 };
# Tip: For improved gaming performance, you can also enable GameMode:
# programs.gamemode.enable = true;
 
#Others
 programs.nix-ld.enable = true;
 programs.java.enable = true;
 hardware.amdgpu.overdrive.enable = true;
 services.lact.enable = true;

#flatpak
 services.flatpak.enable = true;
 systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

}
