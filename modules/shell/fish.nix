{shellAliases}: {lib, osConfig, config, pkgs, ...}: {
  config = lib.mkIf (osConfig.users.defaultUserShell == pkgs.fish || builtins.elem "fish" config.shells.list) {
    programs.fish = {
      enable = true;
      shellAliases = shellAliases.fish;
    };
  };
}
