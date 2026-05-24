{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      HISTSIZE=10000
      SAVEHIST=10000
      HISTFILE="$HOME/.zsh_history"

      setopt AUTO_CD
      setopt HIST_IGNORE_DUPS
      setopt SHARE_HISTORY
    '';
  };
}
