{ config, pkgs, ... }:

{
  # 配置指针主题（解决XWayland黑指针问题）
    home.packages = with pkgs; [
    phinger-cursors
    rose-pine-cursor
    # 或其他主题，如 bibata-cursors
    ];
    home.pointerCursor = {
      name = "rose-pine-cursor";
      package = pkgs.rose-pine-cursor;
      size = 24;
      gtk.enable = true;
      x11.enable = true; # 对XWayland生效的关键
    };
  # 这里可以添加其他主题配置，例如：
  # - gtk.theme, iconTheme
  # - qt.style
  # - 字体等
}
