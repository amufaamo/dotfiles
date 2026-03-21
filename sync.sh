#!/bin/bash
# sync.sh
# dotfilesの変更をGitHubに同期する
# 使い方: bash ~/dotfiles/sync.sh

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES_DIR="$HOME/dotfiles"

# ~/.claude の変更を dotfiles に反映（Windows ではシンボリックリンクの代わり）
echo -e "${GREEN}=== ~/.claude を dotfiles に同期中 ===${NC}"
cp -f ~/.claude/CLAUDE.md "$DOTFILES_DIR/.claude/CLAUDE.md" 2>/dev/null || true
cp -f ~/.claude/settings.json "$DOTFILES_DIR/.claude/settings.json" 2>/dev/null || true
cp -f ~/.claude/hooks/session_logger.py "$DOTFILES_DIR/.claude/hooks/session_logger.py" 2>/dev/null || true
cp -f ~/.claude/commands/learn.md "$DOTFILES_DIR/.claude/commands/learn.md" 2>/dev/null || true
cp -f ~/.claude/commands/skill-save.md "$DOTFILES_DIR/.claude/commands/skill-save.md" 2>/dev/null || true

cd "$DOTFILES_DIR"

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
