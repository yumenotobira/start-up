{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;

    enableBashIntegration = true;

    defaultCommand = "find . -type f";
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
    ];
  };
}
