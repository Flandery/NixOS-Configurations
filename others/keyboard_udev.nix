 { config, ... }:
 {

 # Leobog Hi98C Pro：hidraw 免 sudo 控制灯效（uaccess 给登录会话用户；users 组兜底）
  services.udev.extraRules = ''
    SUBSYSTEM=="hidraw", ATTRS{idVendor}=="258a", ATTRS{idProduct}=="010c", MODE="0660", GROUP="users", TAG+="uaccess"
  '';

 }
