#!/bin/bash
# Generates a commit message for the vault's pending changes via Claude.
# Used as obsidian-git's commitMessageScript; stdout becomes the commit message.

fallback="vault backup: $(date '+%Y-%m-%d %H:%M:%S')"

git add -A
diff=$(git diff --cached HEAD | head -c 8000)
if [ -z "$diff" ]; then
  echo "$fallback"
  exit 0
fi

msg=$("$HOME/.local/bin/claude" -p --model claude-haiku-4-5 \
  "Write a single-line git commit message (imperative mood, no quotes, no surrounding punctuation, max 72 characters) summarizing this diff of personal Obsidian notes:

$diff" 2>/dev/null | tr -d '\n')

if [ -z "$msg" ]; then
  echo "$fallback"
else
  echo "$msg"
fi
