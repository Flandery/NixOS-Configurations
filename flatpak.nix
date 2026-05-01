{ config, lib, pkgs, inputs, ... }:
{
  imports = [
  inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    update.onActivation = true;
    packages = [
    "com.tencent.WeChat"
    ];
  };
}
