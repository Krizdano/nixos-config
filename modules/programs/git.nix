{ pkgs, users, ... }:
{
  programs.git = {
    enable = true;
    diff-so-fancy = {
      enable = true;
    };
    signing = {
      key = null;
      signByDefault = true;
    };

    userName = users.primary.GitUserName;
    userEmail = users.primary.GitUserEmail;
  };

  home.packages = with pkgs; [ git-crypt ];
}
