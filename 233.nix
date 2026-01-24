{ config, lib, pkgs, inputs, ... }:
{
 users.users.Flandre = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
   #     tree
     ];
   };
 networking.hostName = "FlandreScarletNixOS"; # Define your hostname.
 time.timeZone = "Asia/Shanghai";
 environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
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
#    polkit_gnome
#    xdg-desktop-portal-gnome
    # ... maybe other stuff
  ];
# services = {
#  desktopManager.plasma6.enable = true;
#  displayManager.sddm.enable = true;
#  displayManager.sddm.wayland.enable = true;
# };
 services.displayManager.gdm.enable = true;
 services.desktopManager.gnome.enable = true;
 programs.niri.enable = true;  # 启用Niri Wayland合成器（作为GNOME的替代或补充）

 nix.settings = {
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"  # 添加中科大镜像源
      "https://cache.nixos.org/"  # 默认官方缓存
    ];
    experimental-features = [ "nix-command" "flakes" ];  # 启用实验性功能：nix命令增强和flakes支持
  }; 
 nixpkgs.config.allowUnfree = true;
 programs.clash-verge.enable = true;
 programs.clash-verge.tunMode = true;
 programs.firefox.enable = true;
 programs.fish.enable = true;
 services.flatpak.enable = true;
 programs.clash-verge.serviceMode = true;
 networking.firewall.enable = false;
 users.defaultUserShell = pkgs.fish;
 programs.direnv.enable = true;
 programs.gamemode.enable = true;
 zramSwap.enable = true; # Creates a zram block device and uses it as a swap device
# 启用自动垃圾收集
 nix.gc.automatic = true;
# 设置清理选项：删除超过7天的旧世代
 nix.gc.options = "--delete-older-than 7d";
 nix.gc.dates = "weekly";
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

# 可选：为 GTK/Qt 程序设置环境变量（启用Wayland前端后，部分变量可能被覆盖[citation:3]）
 environment.sessionVariables = {
   # 如果你只使用X11应用，可能需要保留这些[citation:3]
   # GTK_IM_MODULE = "fcitx";
   # QT_IM_MODULE = "fcitx";
   XMODIFIERS = "@im=fcitx";
 };
  # 对于NVIDIA显卡用户，硬件驱动配置通常是必须的
  # hardware.nvidia.modesetting.enable = true;
  # services.xserver.videoDrivers = [ "nvidia" ];
#GPU Drivers

#Others
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

#Steam
 programs.steam = {
  enable = true; # Master switch, already covered in installation
  remotePlay.openFirewall = true;  # For Steam Remote Play
  dedicatedServer.openFirewall = true; # For Source Dedicated Server hosting
  # Other general flags if available can be set here.
 };
# Tip: For improved gaming performance, you can also enable GameMode:
# programs.gamemode.enable = true;

}
