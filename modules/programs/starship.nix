_: {
  # starship shell prompt
  programs.starship = {
    enable = true;
    # Note: ZSH integration is disabled here and is set inside zsh.nix (zshrc)
    # This is so it doesn't mess with my vterm intergration for emacs
    enableZshIntegration = false;
    enableNushellIntegration = true;
    enableBashIntegration = true;
    # config
    settings = {
      add_newline = false;
      username = {
        style_user = "bright-white bold";
        style_root = "bright-red bold";
      };
      hostname = {
        style = "bright-green bold";
        ssh_only = true;
      };
      nix_shell = {
        symbol = "";
        format = "[$symbol$name]($style) ";
        style = "bright-purple bold";
      };
      git_branch = {
        only_attached = true;
        format = "[$symbol$branch]($style) ";
        style = "bright-yellow bold";
      };
      git_commit = {
        only_detached = true;
        format = "[ﰖ$hash]($style) ";
        style = "bright-yellow bold";
      };
      git_state = {
        style = "bright-purple bold";
      };
      git_status = {
        style = "bright-green bold";
      };
      directory = {
        read_only = " ";
        truncation_length = 0;
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "bright-blue";
      };
      jobs = {
        style = "bright-green bold";
      };
      character = {
        success_symbol = ''[ 󰑃](bright-blue bold)'';
        error_symbol = "[ 󰑃](bright-red bold)";
        vimcmd_symbol = "[ 󰑃](bright-blue bold)";
      };
    };
  };
}
