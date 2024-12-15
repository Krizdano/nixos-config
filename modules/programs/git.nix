{ pkgs, user, ... }: {
  programs.git = {
    enable = true;
    diff-so-fancy = {
      enable = true;
    };
    signing = {
      key = null;
      signByDefault = true;
    };

    userName = user.GitUserName;
    userEmail = user.GitUserEmail;
  };

  home.packages = with pkgs; [ git-crypt ];
}
