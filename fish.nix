{ config, pkgs, ... }:
{                                                                                                                                          
     programs.fish = {
      enable = true;
     # 禁用 Fish 的欢迎信息
      shellInit = ''
        set -U fish_greeting ""
      '';
     # 仅当处于交互式会话时执行
      interactiveShellInit = ''
        # 运行 fastfetch
        fastfetch
      '';
      shellAliases = {
    # nvim 相关
      nv = "nvim";
      vim = "nvim";  # 将 vim 也指向 nvim
      vi = "nvim";   # 将 vi 也指向 nvim
      f = "fastfetch";
      m = "musicfox";
      };
     };
   # 声明式管理 Starship 提示符
    programs.starship = {
      enable = true;
     # 启用针对 Fish 的集成
      enableFishIntegration = true;
     # 可以在此处添加自定义的 starship.toml 配置
     # settings = { ... };
   };
 
   # 确保 fastfetch 工具已安装在系统中
 #  home.packages = with pkgs; [ 
 #    fastfetch 
 #  ];
}
