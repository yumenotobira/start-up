# tmux-ai-pane: helpers for AI assistant panes (Claude / Codex / Copilot)
#
# Usage:
#   tmux-ai-pane is-ai <pane_pid>   exit 0 if an AI assistant runs in the pane
#   tmux-ai-pane file  <pane_id>    fuzzy file finder popup, insert "@path"
#   tmux-ai-pane grep  <pane_id>    full-text search popup, insert "@path"
#
# `is-ai` walks the pane process subtree and matches argv against the assistant
# names. This is needed because e.g. Copilot runs under node, so the foreground
# command (#{pane_current_command}) is "node", not "copilot".

set -u

# Match an assistant in an argv. claude/codex are native binaries, so match the
# executable token (preceded by /, space or start; ending the token). copilot is
# node-wrapped, so match its package/path component (handles @github/copilot and
# pnpm's @github+copilot store layout). Dotted config dirs like ~/.claude or
# ~/.copilot are deliberately NOT matched.
AI_RE='(^|[/[:space:]])(claude|codex)([[:space:]]|$)|([/+[:space:]]|^)copilot([/[:space:]+@]|$)'

descendants() {
  printf '%s\n' "$1"
  local child
  for child in $(pgrep -P "$1" 2>/dev/null); do
    descendants "$child"
  done
}

is_ai() {
  local root="${1:-}"
  [ -n "$root" ] || return 1
  local pids args
  pids=$(descendants "$root" | tr '\n' ' ')
  [ -n "$pids" ] || return 1
  # Capture argv first, then match in-process: this avoids a `grep` child whose
  # own argv (the pattern) would otherwise appear in the scanned process tree.
  # shellcheck disable=SC2086
  args=$(ps -o args= -p $pids 2>/dev/null)
  [[ "$args" =~ $AI_RE ]]
}

# Resolve the pane to write back to. Inside a display-popup the active pane is
# still the one that launched it, so display-message reports the assistant pane.
# Resolving here (rather than expanding #{pane_id} in the key binding) avoids the
# if-shell then-branch resolving the format against the wrong pane.
target_pane() {
  if [ -n "${1:-}" ]; then
    printf '%s' "$1"
  else
    tmux display-message -p '#{pane_id}'
  fi
}

# Read newline-separated relative paths from stdin and type them, each prefixed
# with "@", back into the calling pane.
insert() {
  local pane="${1:-}" out="" p
  [ -n "$pane" ] || return 0
  while IFS= read -r p; do
    [ -n "$p" ] || continue
    out="${out}@${p} "
  done
  [ -n "$out" ] || return 0
  tmux send-keys -t "$pane" -l "$out"
}

pick_file() {
  fd --type f --hidden --exclude .git \
    | fzf --multi --height=100% --layout=reverse --border \
        --prompt 'file> ' \
        --preview '(bat --style=numbers --color=always {} 2>/dev/null || cat {}) 2>/dev/null' \
        --preview-window 'right,60%'
}

pick_grep() {
  local rg='rg --column --line-number --no-heading --color=always --smart-case --hidden --glob=!.git'
  fzf --multi --ansi --disabled --query '' \
      --height=100% --layout=reverse --border \
      --prompt 'rg> ' \
      --delimiter : \
      --bind "start:reload:$rg {q} || true" \
      --bind "change:reload:sleep 0.1; $rg {q} || true" \
      --preview '(bat --style=numbers --color=always --highlight-line {2} {1} 2>/dev/null || cat {1}) 2>/dev/null' \
      --preview-window 'right,60%,+{2}-/2' \
    | cut -d: -f1 | awk '!seen[$0]++'
}

case "${1:-}" in
  is-ai) is_ai "${2:-}" ;;
  file)  pick_file | insert "$(target_pane "${2:-}")" ;;
  grep)  pick_grep | insert "$(target_pane "${2:-}")" ;;
  *)
    echo "usage: tmux-ai-pane {is-ai <pid>|file [pane_id]|grep [pane_id]}" >&2
    exit 2
    ;;
esac
