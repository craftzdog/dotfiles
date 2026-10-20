#!/bin/bash
# Move the current herdr workspace up or down in the list: herdr-move-workspace up|down
set -eu

case "${1:-}" in
  up) delta=-1 ;;
  down) delta=1 ;;
  *) echo "usage: herdr-move-workspace up|down" >&2; exit 1 ;;
esac

list=$(herdr workspace list)
current="${HERDR_ACTIVE_WORKSPACE_ID:-$(jq -r '.result.workspaces[] | select(.focused) | .workspace_id' <<<"$list")}"
number=$(jq -r --arg id "$current" '.result.workspaces[] | select(.workspace_id == $id) | .number' <<<"$list")
count=$(jq -r '.result.workspaces | length' <<<"$list")

# number is 1-based; insert_index is 0-based and counts the workspace's
# current slot, so moving down has to skip past it
target=$((number - 1 + delta))
[ "$target" -ge 0 ] && [ "$target" -lt "$count" ] || exit 0
index=$target
[ "$delta" -gt 0 ] && index=$((target + 1))

# No CLI for workspace.move; call the socket API directly
python3 - "$current" "$index" <<'PY'
import json, os, socket, sys
s = socket.socket(socket.AF_UNIX)
s.connect(os.environ.get("HERDR_SOCKET_PATH") or os.path.expanduser("~/.config/herdr/herdr.sock"))
s.sendall((json.dumps({"id": "herdr-move-workspace", "method": "workspace.move",
                       "params": {"workspace_id": sys.argv[1], "insert_index": int(sys.argv[2])}}) + "\n").encode())
s.recv(65536)
PY
