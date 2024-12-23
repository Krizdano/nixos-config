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

  config = {
    hardware = lib.mkIf (config.graphics.amdgpuSupport.enable) {
      amdgpu = {
        opencl = {
          enable = true;
        };
        amdvlk = {
          enable = true;
          support32Bit.enable = true;
        };
      };
      graphics = lib.mkIf (config.graphics.enable) {
        enable = true;
      };
    };
  };
}
