{ config, lib, ... }:
{
  options.configDir = lib.mkOption {
    type = lib.types.str;
    default = "/FuranYukiConfigurations/FuranYukiNixOSConfigurations";
    description = "配置仓库在磁盘上的真实路径";
  };
}
