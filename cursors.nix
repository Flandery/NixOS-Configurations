# /FlanderyConfigurations/theme.nix
{ config, pkgs, ... }:

{
  # 配置指针主题（解决XWayland黑指针问题）
  home-manager.users.你的用户名 = { # 请将“你的用户名”替换为实际的用户名
    home.pointerCursor = {
      name = "phinger-cursors-light";
      package = pkgs.phinger-cursors;
      size = 24;
      gtk.enable = true;
      x11.enable = true; # 对XWayland生效的关键
    };
  };

  # 这里可以添加其他主题配置，例如：
  # - gtk.theme, iconTheme
  # - qt.style
  # - 字体等
}
