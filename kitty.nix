{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    settings = {
      # 字体设置
      font_family = "Adwaita Mono";
      font_size = 16;
      
      # 窗口设置
      window_padding_width = 5;
      hide_window_decorations = "yes";
      remember_window_size = "no";
      
      # 透明度
      background_opacity = "0.6";
      
      # 窗口关闭确认
      confirm_os_window_close = 0;
    };
    
    # 主题设置
    # 如果你有 frappe.conf 文件，可以这样包含：
    # extraConfig = ''
    #   include themes/frappe.conf
    # '';
    
    # 或者如果你想直接包含主题内容，可以这样：
    extraConfig = ''
      # BEGIN_KITTY_THEME
      # Noctalia
      include current-theme.conf
      # END_KITTY_THEME
      include ./themes/noctalia.conf
      cursor_trail 3
    '';
 };
}
