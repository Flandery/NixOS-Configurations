{ config, pkgs, ... }:

{
  # LazyVim 运行时依赖（NixOS 无 /usr/bin，需显式提供）
  home.packages = with pkgs; [
    git
    curl
    ripgrep
    fd
    lazygit
    tree-sitter
    gcc
    unzip
    python3
    nodejs
  ];

  # 将 LazyVim 配置软链到 ~/.config/nvim
  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/FlanderysConfigurations/FlanderysNixOSConfigurations/dotfiles/nvim";
}