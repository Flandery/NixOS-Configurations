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
  };
}
