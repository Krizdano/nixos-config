{ pkgs, config, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    dotDir = ".config/zsh";
    history.path = "${config.xdg.dataHome}/zsh/.zsh_history";
    autocd = true;
    shellAliases = {
      vi = "nvim-client";
      vim = "nvim-client";
      ll = "ls -l";
      ls = "ls --color=always";
      notes = ''glow  $NIXOS_CONFIG/notes'';
      re = "pushd $NIXOS_CONFIG; doas nixos-rebuild switch --flake path:.#$(hostname); popd"; # nixos rebuild
      update = "pushd $NIXOS_CONFIG; doas nix flake update; popd";
      gg = "w3m google.com"; # w3m with google
      search = "nix search nixpkgs";
      connect = "kdeconnect-cli";
    };

    completionInit = "autoload -Uz compinit
                      zstyle ':completion:*' menu select
                      zmodload zsh/complist
                      compinit
                      ";

    defaultKeymap = "viins";
    initExtra =
      ''eval "$(starship init zsh)"

      export KEYTIMEOUT=1

      # eat integration
      [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
      source "$EAT_SHELL_INTEGRATION_DIR/zsh"

      # launch w3m with a search query
      ww(){
        "w3m" "http://localhost:8080/search?q=$*"
      }

      conf() {
        pushd $NIXOS_CONFIG
        filename=$(find -name '*.nix' | fzf --preview="pistol {}");
        if  test -f "$filename" ; then
            $EDITOR "$filename"
        fi
        popd
        clear
      }

      sc() {
        pushd $NIXOS_CONFIG
        filename=$(find config/scripts -name '*.sh' | fzf --preview="glow {}")
        if  test -f "$filename" ; then
            $EDITOR "$filename"
        fi
        popd
        clear
      }

      unsetopt BEEP

      # vi mode
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

      # fzf tab completion
      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      # custom syntax highlighting
      ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets pattern root line)

      # Declare the variable
      typeset -A ZSH_HIGHLIGHT_STYLES

      # To have paths colored instead of underlined
      ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'

      ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta,bold'

      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta,bold'

      ZSH_HIGHLIGHT_STYLES[arg0]='fg=cyan,bold'

      ZSH_HIGHLIGHT_STYLES[default]='fg=cyan'

      ZSH_HIGHLIGHT_STYLES[command]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[global-alias]='fg=blue,bold'

      ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue,bold'
      '';
  };
}
