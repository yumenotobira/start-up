{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghq
  ];

  programs.git = {
    enable = true;

    extraConfig = {
      ghq.root = "~/ghq-src";
    };
  };
}
