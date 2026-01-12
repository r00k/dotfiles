#!/bin/bash
input=$(cat)
MODEL=$(echo "$input" | jq -r '.model.display_name')
CWD=$(echo "$input" | jq -r '.workspace.current_dir')

# Get context usage percentage
CONTEXT_SIZE=$(echo "$input" | jq -r '.context_window.context_window_size')
USAGE=$(echo "$input" | jq '.context_window.current_usage')
if [ "$USAGE" != "null" ] && [ "$CONTEXT_SIZE" != "null" ] && [ "$CONTEXT_SIZE" -gt 0 ] 2>/dev/null; then
  CURRENT_TOKENS=$(echo "$USAGE" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
  CONTEXT_PCT=$((CURRENT_TOKENS * 100 / CONTEXT_SIZE))
else
  CONTEXT_PCT=0
fi

# Get git branch and dirty status
if [ -d "$CWD/.git" ] || git -C "$CWD" rev-parse --git-dir > /dev/null 2>&1; then
  BRANCH=$(git -C "$CWD" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [ -n "$BRANCH" ]; then
    # Check if working directory is dirty
    if ! git -C "$CWD" --no-optional-locks diff --quiet 2>/dev/null || \
       ! git -C "$CWD" --no-optional-locks diff --cached --quiet 2>/dev/null; then
      DIRTY="*"
    else
      DIRTY=""
    fi
    printf "%s | %s%s | %d%%" "$MODEL" "$BRANCH" "$DIRTY" "$CONTEXT_PCT"
  else
    printf "%s | %d%%" "$MODEL" "$CONTEXT_PCT"
  fi
else
  printf "%s | %d%%" "$MODEL" "$CONTEXT_PCT"
fi
