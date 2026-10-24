{ config, pkgs, ... }:

{
  # ── 让“在文件管理器中打开文件夹”(MIME: inode/directory) 默认使用 Dolphin ──
  #
  # 为什么要写在这里（而不是只靠 NixOS 的 xdg.mime.defaultApplications）：
  #   Steam 跑在 bwrap + FHS 沙箱里，沙箱的 /etc 是重新拼出来的 tmpfs，
  #   只从宿主机链接了 /etc/profiles、/etc/static、/etc/fonts 等固定条目，
  #   /etc/xdg 不在其中 —— 所以沙箱里的 xdg-open 看不到 NixOS 生成的
  #   /etc/xdg/mimeapps.list，于是退回 mimeinfo.cache 兜底扫描，命中
  #   kitty 自带的 kitty-open.desktop，最终执行 `kitty +open <目录>`（弹终端）。
  #
  # 而 $HOME 在沙箱里是完整可见的，且 $XDG_CONFIG_HOME/mimeapps.list 是
  # xdg-mime / xdg-open 查找顺序的第一站。用 home-manager 接管它即可，
  # 同时 HM 还会生成一份 ~/.local/share/applications/mimeapps.list 作兼容。
  #
  # 下面 [Default Applications] / [Added Associations] 两组内容是从原来手写的
  # ~/.config/mimeapps.list 原样迁移过来的，只是新增了 inode/directory 一行。

  xdg.mimeApps = {
    enable = true;

    # 原来的 [Default Applications]
    defaultApplications = {
      # 关键新增：文件夹用 Dolphin
      "inode/directory" = "org.kde.dolphin.desktop";

      "x-scheme-handler/clash" = "clash-verge.desktop";
      "x-scheme-handler/clash-verge" = "clash-verge.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
      "x-scheme-handler/opencode" = "ai.opencode.desktop.desktop";
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
      "x-scheme-handler/zcode" = "zcode.desktop";
    };

    # 原来的 [Added Associations]
    associations.added = {
      "x-scheme-handler/clash" = "clash-verge.desktop";
      "x-scheme-handler/clash-verge" = "clash-verge.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/chrome" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/x-extension-htm" = "firefox.desktop";
      "application/x-extension-html" = "firefox.desktop";
      "application/x-extension-shtml" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
      "application/x-extension-xhtml" = "firefox.desktop";
      "application/x-extension-xht" = "firefox.desktop";
      "image/png" = "org.kde.gwenview.desktop";
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
      "x-scheme-handler/zcode" = "zcode.desktop";
    };
  };

  # 首次激活时 ~/.config/mimeapps.list 还是手写的普通文件且内容不同，
  # home-manager 默认会直接报 "would be clobbered" 并中断激活；
  # 打开这个开关让旧文件被改名为 ~/.config/mimeapps.list.backup。
  # 迁移成功之后这一行可以删掉（留着也无害）。
  home.backupFileExtension = "backup";
}