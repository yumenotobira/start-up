{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ghq
    delta
    lazygit
  ];

  programs.gh = {
    enable = true;
  };

  programs.git = {
    enable = true;

    settings = {
      ghq.root = "~/ghq-src";

      core = {
        pager = "delta";
      };

      interactive = {
        diffFilter = "delta --color-only";
      };

      delta = {
        navigate = true;
        side-by-side = true;
        line-numbers = true;
        syntax-theme = "Monokai Extended";
      };
    };
  };
}
