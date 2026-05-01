{ config, lib, pkgs, inputs, ... }:
{
  imports = [
  inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    packages = [
    "com.spotify.Client"
    ];
  };
}
