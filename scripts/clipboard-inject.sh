#!/usr/bin/env bash
set -euo pipefail
TARGET="${1:-${HOME}/scrolls/active-context.md}"
termux-clipboard-set < "$TARGET"
