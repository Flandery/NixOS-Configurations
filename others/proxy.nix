{ config, lib, pkgs, inputs, ... }:
{
#networking.proxy = {
#  default = "http://127.0.0.1:7897";
#  noProxy = "127.0.0.1,localhost,::1,mirrors.ustc.edu.cn,mirrors.tuna.tsinghua.edu.cn,.cn";
#};
programs.clash-verge = {
  enable = true;
  serviceMode = true;   # 内核归 GUI
  tunMode = true;        # caps 仍在 wrapper 上
};
}
