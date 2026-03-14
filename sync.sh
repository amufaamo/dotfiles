#!/bin/bash
# sync.sh
# dotfilesの変更をGitHubに同期する
# 使い方: bash ~/dotfiles/sync.sh

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES_DIR="$HOME/dotfiles"

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
