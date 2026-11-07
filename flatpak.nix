{ config, lib, pkgs, inputs, ... }:
{
  imports = [
  inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
      onActivation = true;
    };
    packages = [
    "com.tencent.WeChat"
    "io.gitlab.theevilskeleton.Upscaler"
    ];
  overrides = {
    settings."com.tencent.WeChat" = {
      Environment.QT_IM_MODULE = "fcitx";
      "Session Bus Policy" = {
      "org.fcitx.Fcitx5" = "talk";
      "org.freedesktop.portal.Fcitx" = "talk";
      };
    };
   };
  };
}
