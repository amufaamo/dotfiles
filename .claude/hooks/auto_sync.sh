#!/bin/bash
# auto_sync.sh
# Stop hook: ai-rulesに変更があれば自動でcommit/pushする

CLAUDE_LINK="$(readlink ~/.claude/CLAUDE.md 2>/dev/null || true)"
if [ -z "$CLAUDE_LINK" ]; then
    exit 0
fi

AI_RULES_DIR="$(dirname "$(dirname "$CLAUDE_LINK")")"
if [ ! -d "$AI_RULES_DIR/.git" ]; then
    exit 0
fi

cd "$AI_RULES_DIR"

# 未コミットの変更または未追跡ファイルがあればコミット&プッシュ
if ! git diff --quiet || ! git diff --staged --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    git add -A
    git commit -m "自動同期: $(date '+%Y-%m-%d %H:%M')" --quiet
    git push --quiet 2>/dev/null || true
fi
