{ pkgs, users, user, ... }:{
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = false;
    users = {
      root = {
        inherit (users.root) hashedPassword;
      };
      ${user.userName} = {
        inherit (user) hashedPassword;
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" "audio" "adbusers" ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFjlpaBY16cZj0Vu4qZtH0Ph7ewUBt7vkwkhJj/+GOKG Felix"
        ];
        packages = with pkgs; [
          # user packages
        ];
      };
    };
  };
}
