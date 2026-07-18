#!/usr/bin/env bash
set -euo pipefail

herdr_bin="${HERDR_BIN_PATH:-herdr}"
plugin_id="${HERDR_PLUGIN_ID:-beomjungil.lazygit-overlay}"

args=(
  plugin pane open
  --plugin "$plugin_id"
  --entrypoint lazygit
  --placement popup
  --width "90%"
  --height "85%"
  --focus
)

focused_cwd="$(
  HERDR_CONTEXT_JSON="${HERDR_PLUGIN_CONTEXT_JSON:-}" python3 - <<'PY' 2>/dev/null || true
import json
import os

raw = os.environ.get("HERDR_CONTEXT_JSON", "")
if not raw:
    raise SystemExit

try:
    value = json.loads(raw).get("focused_pane_cwd", "")
except Exception:
    raise SystemExit

if isinstance(value, str) and value:
    print(value)
PY
)"

if [[ -n "$focused_cwd" ]]; then
  args+=(--cwd "$focused_cwd")
fi

exec "$herdr_bin" "${args[@]}"
