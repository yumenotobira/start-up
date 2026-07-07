{ config, pkgs, ... }:

# claude-code-trace (https://github.com/delexw/claude-code-trace)
#
# npm/nixpkgs いずれにもパッケージが無く、本体は Tauri(Rust)+Node+Python の複合アプリ。
# README 公式サポートの web モードを Docker で動かすラッパー `cctrace` を提供する。
#   cctrace          # イメージが無ければ build してから起動 (http://localhost:1421)
#   cctrace build    # Docker イメージのビルドのみ
#   cctrace update   # ソースを git pull してイメージを再ビルド
#
# 環境変数で挙動を上書き可能:
#   CCTRACE_SRC   ソース clone 先 (default: ~/.local/share/claude-code-trace)
#   CCTRACE_PORT  ホスト側公開ポート (default: 1421)
let
  cctrace = pkgs.writeShellApplication {
    name = "cctrace";
    runtimeInputs = [ pkgs.docker pkgs.git ];
    text = ''
      SRC_DIR="''${CCTRACE_SRC:-$HOME/.local/share/claude-code-trace}"
      PORT="''${CCTRACE_PORT:-1421}"
      IMAGE="claude-code-trace:local"
      REPO="https://github.com/delexw/claude-code-trace.git"

      ensure_src() {
        if [ ! -d "$SRC_DIR/.git" ]; then
          echo "cctrace: cloning $REPO -> $SRC_DIR"
          git clone --depth 1 "$REPO" "$SRC_DIR"
        fi
      }

      build_image() {
        ensure_src
        echo "cctrace: building docker image $IMAGE ..."
        docker build -t "$IMAGE" "$SRC_DIR"
      }

      cmd="''${1:-run}"
      case "$cmd" in
        update)
          ensure_src
          git -C "$SRC_DIR" pull --ff-only
          build_image
          ;;
        build)
          build_image
          ;;
        run)
          if ! docker image inspect "$IMAGE" >/dev/null 2>&1; then
            build_image
          fi
          echo "cctrace: open http://localhost:$PORT"
          exec docker run --rm -p "$PORT:1421" \
            -v "$HOME/.claude:/home/app/.claude:ro" \
            "$IMAGE"
          ;;
        *)
          echo "usage: cctrace [run|build|update]" >&2
          exit 1
          ;;
      esac
    '';
  };
in
{
  home.packages = [ cctrace ];
}
