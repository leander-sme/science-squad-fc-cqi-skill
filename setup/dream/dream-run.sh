#!/bin/bash
# Does the actual dream run, in the foreground. Always launched by launchd, never
# backgrounded — a backgrounded child gets killed when its launchd job exits.
# Both entry points (login/07:30, and the first Claude session of the day) reach
# this through launchd, so the stamp below is what keeps it to one run per day.

DIR="$HOME/.claude/dream"
STAMP="$DIR/last-trigger"
TODAY=$(date +%F)
LOG="$DIR/logs/$TODAY.log"

mkdir -p "$DIR/logs"

[ -f "$STAMP" ] && [ "$(cat "$STAMP")" = "$TODAY" ] && exit 0

# Stamp before running, so the dream's own session can't re-trigger this.
echo "$TODAY" > "$STAMP"

# launchd hands over a bare environment; claude needs the usual paths.
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

CLAUDE=$(command -v claude)
if [ -z "$CLAUDE" ]; then
  echo "$(date '+%F %T') FAILED — no claude binary on PATH" >> "$LOG"
  rm -f "$STAMP"
  exit 0
fi

echo "$(date '+%F %T') starting dream run" >> "$LOG"
"$CLAUDE" -p "/dream" --permission-mode auto --max-turns 60 >> "$LOG" 2>&1
CODE=$?
echo "$(date '+%F %T') finished, exit code $CODE" >> "$LOG"

# A run that failed shouldn't hold the stamp — let the next trigger retry.
[ $CODE -ne 0 ] && rm -f "$STAMP"

exit 0
