{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghq
    gh
  ];

  programs.git = {
    enable = true;

    settings = {
      ghq.root = "~/ghq-src";
    };
  };
}
