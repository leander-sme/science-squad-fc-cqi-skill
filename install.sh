#!/usr/bin/env bash
# Copy the skills and agents in this repo into ~/.claude/
set -euo pipefail

cd "$(dirname "$0")"
force=${1:-}

install_into() {
  local src_dir=$1 dest_dir=$2
  mkdir -p "$dest_dir"
  for item in "$src_dir"/*/; do
    local name
    name=$(basename "$item")
    if [ -e "$dest_dir/$name" ] && [ "$force" != "--force" ]; then
      echo "skip   $dest_dir/$name (exists — pass --force to overwrite)"
      continue
    fi
    rm -rf "$dest_dir/$name"
    cp -R "$item" "$dest_dir/$name"
    echo "install $dest_dir/$name"
  done
}

install_into skills "$HOME/.claude/skills"
install_into agents "$HOME/.claude/agents"

echo
echo "Done. Restart Claude Code, then run /cqi-flashcard or /dream"
