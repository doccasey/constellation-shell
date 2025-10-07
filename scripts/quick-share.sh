#!/usr/bin/env bash
set -euo pipefail
FILE="${HOME}/scrolls/active-context.md"
termux-share -a send -c "/" "$FILE"
