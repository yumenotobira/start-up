{ config, pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [
    ghq
    delta
    lazygit
  ];

  programs.gh = {
    enable = true;
    # issue への画像添付 (--attach) は v2.99.0+ のため unstable から取る
    package = pkgs-unstable.gh;
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
