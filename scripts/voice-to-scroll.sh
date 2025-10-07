#!/usr/bin/env bash
set -euo pipefail
NOTES="${HOME}/scrolls/voice-notes.md"
transcript=$(termux-speech-to-text)
timestamp=$(date '+%Y-%m-%dT%H:%M:%S%z')
{
  echo "### $timestamp"
  echo "$transcript"
  echo
} >> "$NOTES"
