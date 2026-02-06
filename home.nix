{ config, pkgs, inputs, ... }: 
{
  # 指定此配置用于哪个用户
  home.username = "Flandre";
  home.homeDirectory = "/home/Flandre";
  # 设置鼠标指针大小以及字体 DPI（适用于 4K 显示器）
  xresources.properties = {
    "Xcursor.size" = 24;
    #"Xft.dpi" = 172;
  };
  imports = [
    ./fish.nix
    ./kitty.nix
    #./cursors.nix
    ./niri.nix
    ./fastfetch.nix
    ./ghostty.nix
    # 你可以继续导入更多模块
    #./noctalia.nix
  ];
  # 声明要管理的配置文件（启用后，Home Manager 会接管并生成它们）
  #programs.bash = {
  #  enable = true;
  #  initExtra = ''echo "Hello from Home Manager!"'';
  #};

  # 安装用户级别的软件包
  #home.packages = with pkgs; [
  #  neovim
  #  htop
  #  git
  #];
    # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # 基本的 Home Manager 设置
  home.stateVersion = "26.05"; # 与你当前 NixOS 版本保持一致
}
