# Constellation Shell

A scroll-powered, multi-agent orchestration toolkit for Termux on Android.
This project lets you route context between Claude, GPT, Copilot, and others using bash scripts and markdown scrolls.

## Structure

- `scripts/` — Bash tools for routing, sharing, clipboard, and speech
- `scrolls/` — Scroll templates and action checklists
- `examples/` — Sample scrolls for testing

## Setup

1. Install Termux + required packages: `fzf`, `bat`, `termux-api`, `jq`, `curl`
2. Add your OpenAI key as `OPENAI_API_KEY` in your `.bashrc` or env
3. Use `scripts/orla-dispatch.sh` to route context between agents
