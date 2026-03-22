#!/bin/bash
# session_start.sh
# UserPromptSubmit hook: Claude起動時にai-rulesを最新化する（1時間に1回）

PULL_STAMP="$HOME/.claude/learning/last_pull_time"
NOW=$(date +%s)
LAST=$(cat "$PULL_STAMP" 2>/dev/null || echo 0)
THRESHOLD=3600  # 1時間

if [ $((NOW - LAST)) -gt $THRESHOLD ]; then
    CLAUDE_LINK="$(readlink ~/.claude/CLAUDE.md 2>/dev/null || true)"
    if [ -n "$CLAUDE_LINK" ]; then
        AI_RULES_DIR="$(dirname "$(dirname "$CLAUDE_LINK")")"
        if [ -d "$AI_RULES_DIR/.git" ]; then
            cd "$AI_RULES_DIR" && git pull --quiet --rebase 2>/dev/null || true
        fi
    fi
    mkdir -p "$(dirname "$PULL_STAMP")"
    echo "$NOW" > "$PULL_STAMP"
fi
