#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

fake_herdr="$tmp_dir/herdr"
argv_file="$tmp_dir/argv"

cat >"$fake_herdr" <<'SCRIPT'
#!/usr/bin/env bash
printf '%s\n' "$@" >"$HERDR_TEST_ARGV_FILE"
SCRIPT
chmod +x "$fake_herdr"

HERDR_BIN_PATH="$fake_herdr" \
HERDR_PLUGIN_ID="beomjungil.lazygit-overlay" \
HERDR_PANE_ID="focused-pane" \
HERDR_PLUGIN_CONTEXT_JSON='{"focused_pane_cwd":"/Users/example/repo"}' \
HERDR_TEST_ARGV_FILE="$argv_file" \
"$repo_root/scripts/open.sh"

if grep -qx -- "--target-pane" "$argv_file"; then
  echo "open.sh must not pass --target-pane for overlay panes" >&2
  cat "$argv_file" >&2
  exit 1
fi

grep -qx -- "plugin" "$argv_file"
grep -qx -- "pane" "$argv_file"
grep -qx -- "open" "$argv_file"
grep -qx -- "--placement" "$argv_file"
grep -qx -- "overlay" "$argv_file"
grep -qx -- "--focus" "$argv_file"
grep -qx -- "--cwd" "$argv_file"
grep -qx -- "/Users/example/repo" "$argv_file"
