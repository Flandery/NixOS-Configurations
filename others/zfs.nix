# ZFS 支持（数据盘 / 快照能力，根文件系统保持 LUKS + btrfs 不变）
#
# 关键约束 —— 内核必须能编译出 zfs 内核模块：
#   本仓库 nixpkgs 里 zfs = 2.4.4，只支持到 6.18.x；
#   linuxPackages_latest（7.3.4）对应的 zfs_2_4 是 meta.broken = true，
#   所以 configuration.nix 里 boot.kernelPackages 固定为 pkgs.linuxPackages（6.18.63）。
#   以后 nixpkgs 里 zfs 支持新内核时，再把那行改回 linuxPackages_latest。
#
# 启用后：modinfo zfs / zpool / zfs 命令可用，可以导入已有池、创建新池、做快照。
# 注意：Secure Boot 一旦真正 enforced，未签名的树外模块会被 lockdown 拦住；
#       当前 efivar SecureBoot=0（未启用）、lockdown=none，所以不受影响。
{ config, lib, pkgs, ... }:

{
  # 让 zfs 进入 stage-2 支持的文件系统列表，同时拉入 zfs 内核模块与用户态工具
  boot.supportedFilesystems = [ "zfs" ];

  # 26.11 默认仍是 true；显式设 false，避免启动时对“所有能找到的池”强制 import
  # 造成临近盘/旧盘被误挂（forceImportAll 也依赖它）
  boot.zfs.forceImportRoot = false;

  # 需要开机自动 import 的池写在这里，例如 [ "tank" ]。
  # 只挂 fileSystems 里声明的数据集时可以留空（systemd 的 zfs-import 会先跑）。
  boot.zfs.extraPools = [ ];

  # 池成员盘设备路径不稳时用 partuuid 固定，例如 "/dev/disk/by-partuuid"
  # boot.zfs.devNodes = "/dev/disk/by-partuuid";

  # ZFS 用 hostId 标识池的导入归属，必须 8 位十六进制，且同机唯一
  networking.hostId = "654de7a3";

  services.zfs.autoScrub = {
    enable = true;
    interval = "monthly";
  };
  services.zfs.trim.enable = true;

  # 自动快照：开启后还要给数据集打标记
  #   zfs set com.sun:auto-snapshot=true tank/data
  # services.zfs.autoSnapshot.enable = true;

  # 池立即生效于启动期（在 fileSystems 里声明数据集时用这些写法）：
  #
  # fileSystems."/mnt/tank-data" = {
  #   device = "tank/data";
  #   fsType = "zfs";
  #   options = [ "zfsutil" ];
  # };
  #
  # zvol 当块设备用（比如给 libvirt 或 LUKS 容器）：
  #
  # fileSystems."/var/lib/libvirt/images" = {
  #   device = "tank/libvirt";
  #   fsType = "zfs";
  #   options = [ "zfsutil" ];
  # };

  environment.systemPackages = with pkgs; [
    zfs-autobackup
    zfs-prune-snapshots
    sanoid
  ];
}