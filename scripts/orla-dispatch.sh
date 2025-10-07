#!/usr/bin/env bash
set -euo pipefail

# Routes context between AI agents on Termux/Android

for cmd in fzf bat termux-clipboard-set curl jq; do
  command -v "$cmd" >/dev/null 2>&1 || {
    echo "Error: '$cmd' is required but not installed." >&2
    exit 1
  }
done

SCROLL_DIR="${HOME}/scrolls"
ACTIVE_CONTEXT="${SCROLL_DIR}/active-context.md"
OPENAI_API_KEY="${OPENAI_API_KEY:-}"
CLAUDE_PACKAGE="${CLAUDE_PACKAGE:-com.anthropic.android}"
COPILOT_CMD="${COPILOT_CMD:-gh copilot chat}"

usage() {
  echo "Usage: $0 {claude|gpt|copilot|memory}"
  exit 1
}

if [ $# -ne 1 ]; then usage; fi

agent="$1"
case "$agent" in
  claude)
    termux-clipboard-set < "$ACTIVE_CONTEXT"
    am start -n "${CLAUDE_PACKAGE}/.MainActivity"
    ;;
  gpt)
    context="$(< "$ACTIVE_CONTEXT")"
    curl -s       -H "Authorization: Bearer $OPENAI_API_KEY"       -H "Content-Type: application/json"       -d @- https://api.openai.com/v1/chat/completions <<EOF | jq -r '.choices[0].message.content'
{
  "model": "gpt-4o",
  "messages": [
    { "role": "system", "content": "You are Orla, a helpful assistant." },
    { "role": "user",   "content": "'"${context//'/'\'}"'" }
  ]
}
EOF
    ;;
  copilot)
    content="$(< "$ACTIVE_CONTEXT")"
    $COPILOT_CMD --body "$content"
    ;;
  memory)
    cd "$SCROLL_DIR"
    selection=$(fzf --height 40% --preview "bat --style=numbers --color=always {}")
    [ -n "$selection" ] && nvim "$selection"
    ;;
  *) usage ;;
esac
