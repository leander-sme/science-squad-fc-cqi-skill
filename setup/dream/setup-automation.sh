#!/usr/bin/env bash
# Optional: make /dream run once a day on its own (macOS).
# Copies the two scripts into ~/.claude/dream/, writes a launchd job that fires at
# login and at 07:30, and loads it. Re-runnable.
set -euo pipefail

cd "$(dirname "$0")"

DIR="$HOME/.claude/dream"
LABEL=com.sme.claude-dream
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"

mkdir -p "$DIR/logs" "$HOME/Dream Reports" "$HOME/Library/LaunchAgents"
cp dream-run.sh dream-trigger.sh "$DIR/"
chmod +x "$DIR/dream-run.sh" "$DIR/dream-trigger.sh"

# Reports are written to ~/Dream Reports; the symlink lets the skill reach them
# under ~/.claude/dream/reports without the folder being hidden in Finder.
ln -sfn "$HOME/Dream Reports" "$DIR/reports"

cat > "$PLIST" <<PLISTEOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$LABEL</string>

    <!-- Runs the dream in the foreground. launchd keeps this process alive until it
         finishes; nothing here is backgrounded, because launchd kills backgrounded
         children as soon as the job's main process exits. -->
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$DIR/dream-run.sh</string>
    </array>

    <!-- Fires at login. -->
    <key>RunAtLoad</key>
    <true/>

    <!-- And at 07:30 each day. If the laptop was asleep, macOS runs it on wake. -->
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>7</integer>
        <key>Minute</key>
        <integer>30</integer>
    </dict>

    <!-- A dream run takes many minutes; don't let launchd time it out. -->
    <key>ExitTimeOut</key>
    <integer>0</integer>

    <key>StandardOutPath</key>
    <string>$DIR/logs/launchd.log</string>
    <key>StandardErrorPath</key>
    <string>$DIR/logs/launchd.log</string>
</dict>
</plist>
PLISTEOF

launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST"

echo "Installed $LABEL — runs at login and 07:30 daily."
echo
echo "Optional, to also catch the first Claude session of the day, add this to the"
echo "\"hooks\" block of ~/.claude/settings.json:"
cat <<'HOOKEOF'

  "SessionStart": [
    {
      "matcher": "startup",
      "hooks": [
        { "type": "command", "command": "bash ~/.claude/dream/dream-trigger.sh", "timeout": 10 }
      ]
    }
  ]
HOOKEOF
