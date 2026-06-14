{ config, pkgs, ... }:

let
  # Helper invoked from tmux key bindings. Runtime deps are baked onto PATH so
  # it works regardless of how tmux's server environment was started.
  tmux-ai-pane = pkgs.writeShellScriptBin "tmux-ai-pane" ''
    export PATH="${pkgs.lib.makeBinPath [
      pkgs.fzf
      pkgs.fd
      pkgs.ripgrep
      pkgs.procps
      pkgs.gnugrep
      pkgs.gawk
      pkgs.coreutils
    ]}:$PATH"
    ${builtins.readFile ./tmux/ai-pane.sh}
  '';
in
{
  home.packages = with pkgs; [
    tmux
    tmuxp
    tmux-ai-pane
  ];

  home.file.".config/tmux/tmux.conf".source = ./tmux.conf;
}
