{ hunk, ... }:

{
  imports = [ hunk.homeManagerModules.default ];

  programs.hunk = {
    enable = true;

    # git pager は delta を使っているため git 統合は無効のまま。
    # hunk を git pager にしたい場合は true にする（conf/git.nix の delta 設定と要調整）。
    enableGitIntegration = false;

    settings = {
      theme = "graphite";
      mode = "split";
      line_numbers = true;
    };
  };
}
