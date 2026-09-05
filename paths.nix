{ config, lib, ... }:
{
  options.configDir = lib.mkOption {
    type = lib.types.str;
    default = "/FlanderysConfigurations/FlanderysNixOSConfigurations";
    description = "配置仓库在磁盘上的真实路径";
  };
}