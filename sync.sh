#!/bin/bash
# sync.sh
# ai-rulesの変更をGitHubに同期する
# 使い方: bash /path/to/ai-rules/sync.sh

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# シンボリックリンクから実パスを自動検出
# ~/.claude/CLAUDE.md が ai-rules リポジトリへのシンボリックリンクになっている場合に対応
if CLAUDE_LINK="$(readlink ~/.claude/CLAUDE.md 2>/dev/null)"; then
  AI_RULES_DIR="$(dirname "$(dirname "$CLAUDE_LINK")")"
else
  # フォールバック: このスクリプト自体の場所を基準にする
  AI_RULES_DIR="$(cd "$(dirname "$0")" && pwd)"
fi

echo -e "${GREEN}=== AI_RULES_DIR: $AI_RULES_DIR ===${NC}"

# ~/.claude の変更を ai-rules に反映（シンボリックリンクでない場合のコピー）
echo -e "${GREEN}=== ~/.claude を ai-rules に同期中 ===${NC}"
cp -f ~/.claude/CLAUDE.md "$AI_RULES_DIR/.claude/CLAUDE.md" 2>/dev/null || true
cp -f ~/.claude/settings.json "$AI_RULES_DIR/.claude/settings.json" 2>/dev/null || true
cp -f ~/.claude/hooks/session_logger.py "$AI_RULES_DIR/.claude/hooks/session_logger.py" 2>/dev/null || true
cp -f ~/.claude/commands/learn.md "$AI_RULES_DIR/.claude/commands/learn.md" 2>/dev/null || true
cp -f ~/.claude/commands/skill-save.md "$AI_RULES_DIR/.claude/commands/skill-save.md" 2>/dev/null || true

cd "$AI_RULES_DIR"

# 変更があるか確認
if git diff --quiet && git diff --staged --quiet; then
  echo -e "${YELLOW}変更はありません${NC}"
  exit 0
fi

# 変更内容を表示
echo -e "${GREEN}=== 変更されたファイル ===${NC}"
git diff --name-only
git diff --staged --name-only

# 自動コミットメッセージ（日時付き）
MSG="自動同期: $(date '+%Y-%m-%d %H:%M')"

git add -A
git commit -m "$MSG"
git push

echo ""
echo -e "${GREEN}✅ GitHubに同期しました${NC}"
echo "   $MSG"
