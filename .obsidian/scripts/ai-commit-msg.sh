#!/bin/bash
# Generates a commit message for the vault's pending changes via Codex.
# Used as obsidian-git's commitMessageScript; stdout becomes the commit message.

fallback="vault backup: $(date '+%Y-%m-%d %H:%M:%S')"

git add -A
diff=$(git diff --cached HEAD | head -c 8000)
if [ -z "$diff" ]; then
  echo "$fallback"
  exit 0
fi

if ! raw=$("$HOME/.local/bin/codex" exec \
  --ephemeral \
  --sandbox read-only \
  --color never \
  --model gpt-5.6-luna \
  -c 'model_reasoning_effort="low"' \
  "Summarize the following diff of Obsidian notes as a git commit message.

Rules:
- Output ONLY the commit message text, nothing else.
- One line, imperative mood, max 72 characters.
- Plain text only. No markdown, no backticks, no code fences, no quotation
  marks, no surrounding punctuation.
- Do not explain your reasoning and do not include a character count.

Diff:
$diff" 2>/dev/null); then
  echo "$fallback"
  exit 0
fi

# Do not allow an authentication error to become the commit message.
case "$raw" in
  *"Not logged in"*|*"Please run /login"*)
    echo "$fallback"
    exit 0
    ;;
esac

# Sanitize in case the model still adds formatting: drop code-fence markers
# (keeping their contents), strip stray backticks/quotes, remove a trailing
# \"(NN characters)\" note, then take the first non-empty line capped at 72 chars.
msg=$(printf '%s' "$raw" \
  | sed 's/```//g' \
  | tr -d '`"' \
  | sed -E 's/\([0-9]+ characters?\)//g' \
  | awk 'NF {sub(/^[[:space:]]+/, ""); sub(/[[:space:]]+$/, ""); print; exit}' \
  | cut -c1-72)

if [ -z "$msg" ]; then
  echo "$fallback"
else
  echo "$msg"
fi
