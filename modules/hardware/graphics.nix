{config, lib, ...}: {
  options.graphics = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    amdgpuSupport = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = let cfg = config.graphics; in {
    hardware = lib.mkIf cfg.amdgpuSupport.enable {
      amdgpu = {
        opencl = {
          enable = true;
        };
        amdvlk = {
          enable = true;
          support32Bit.enable = true;
        };
      };
      graphics = lib.mkIf cfg.enable {
        enable = true;
      };
    };
  };
}
