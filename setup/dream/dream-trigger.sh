#!/bin/bash
# Asks launchd to start today's dream run. Called from the SessionStart hook.
# It does not run claude itself — launchd owns the process, so it survives this
# script (and the Claude session) exiting. dream-run.sh holds the once-a-day stamp.
# Always exits 0 — a failure here must never block a session starting.

DIR="$HOME/.claude/dream"
STAMP="$DIR/last-trigger"
TODAY=$(date +%F)

# Cheap check first, so an ordinary session start does no work at all.
[ -f "$STAMP" ] && [ "$(cat "$STAMP")" = "$TODAY" ] && exit 0

launchctl kickstart "gui/$(id -u)/com.sme.claude-dream" >/dev/null 2>&1

echo "A dream run has just started in the background — it reviews recent sessions and produces a report of proposed memory updates. It does not affect this session."
exit 0
