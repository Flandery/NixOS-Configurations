# /swap 上的 swapfile
#
# 位置：btrfs 嵌套子卷 @FuranYukiNixOS/swap（Subvolume ID 265，父卷 256），
#       未单独挂载，随 / 一起可见，压缩选项从根子卷继承。
#
# 前提（重建文件时用这条，btrfs-progs >= 6.1 会自动 nocow + 预分配）：
#   sudo btrfs filesystem mkswapfile --size 32g /swap/swapfile
# 老办法：
#   sudo truncate -s 0 /swap/swapfile && sudo chattr +C /swap/swapfile \
#     && sudo fallocate -l 32G /swap/swapfile && sudo chmod 600 /swap/swapfile \
#     && sudo mkswap /swap/swapfile
# 没有 nocow 的 swapfile 会被 btrfs 拒绝：swapon: Invalid argument。
#
# 不要在这里写 size：文件已经预分配好 32 GiB，
# 写了会让 NixOS 每次激活都重新 fallocate 一遍。
{ lib, ... }:

{
  swapDevices = [
    {
      device = "/swap/swapfile";
      # zramSwap 的 priority 是 10，这里低一档：
      # 优先用 zram，swapfile 只在内存压力大时兜底，避免磁盘换页拖慢编译。
      priority = 5;
    }
  ];
}
