{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    tmux
    tmuxp
  ];

  home.file.".config/tmux/tmux.conf".source = ./tmux.conf;
}
