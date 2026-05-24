{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghq
  ];

  programs.git = {
    enable = true;

    settings = {
      ghq.root = "~/ghq-src";
    };
  };
}
