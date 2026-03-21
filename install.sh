#!/bin/bash
# install.sh
# 新しいPCでのセットアップスクリプト
# 使い方: bash install.sh

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo -e "${GREEN}=== Claude Code 自己進化システム セットアップ ===${NC}"
echo ""

# バックアップ
if [ -d "$CLAUDE_DIR" ]; then
  BACKUP="$HOME/.claude.backup.$(date +%Y%m%d_%H%M%S)"
  echo -e "${YELLOW}既存の ~/.claude を $BACKUP にバックアップします${NC}"
  cp -r "$CLAUDE_DIR" "$BACKUP"
fi

mkdir -p "$CLAUDE_DIR"/{hooks,commands,skills/auto-evolved,learning}

# シンボリックリンクを作成
echo "シンボリックリンクを作成中..."

files=(
  "CLAUDE.md"
  "settings.json"
)
for f in "${files[@]}"; do
  src="$DOTFILES_DIR/.claude/$f"
  dst="$CLAUDE_DIR/$f"
  if [ -f "$src" ]; then
    ln -sf "$src" "$dst"
    echo "  ✅ $f"
  fi
done

# hooks
for f in "$DOTFILES_DIR/.claude/hooks/"*; do
  fname=$(basename "$f")
  ln -sf "$f" "$CLAUDE_DIR/hooks/$fname"
  chmod +x "$f"
  echo "  ✅ hooks/$fname"
done

# commands
for f in "$DOTFILES_DIR/.claude/commands/"*; do
  fname=$(basename "$f")
  ln -sf "$f" "$CLAUDE_DIR/commands/$fname"
  echo "  ✅ commands/$fname"
done

# learningディレクトリの初期化
INSIGHTS="$CLAUDE_DIR/learning/insights.jsonl"
APPLIED="$CLAUDE_DIR/learning/applied.jsonl"
SESSION_LOG="$CLAUDE_DIR/learning/session_log.jsonl"

for logfile in "$INSIGHTS" "$APPLIED" "$SESSION_LOG"; do
  if [ ! -f "$logfile" ]; then
    touch "$logfile"
    echo "  ✅ $(basename $logfile) を初期化"
  fi
done

echo ""
echo -e "${GREEN}=== セットアップ完了 ===${NC}"
echo ""
echo "使い方:"
echo "  /learn      → セッション終了後に教訓を記録・進化提案"
echo ""
echo "  /skill-save → うまくいったパターンをすぐSkillに保存"
echo ""
echo -e "${YELLOW}次のステップ:${NC}"
echo "  1. Claude Codeを起動: claude"
echo "  2. 作業後に /learn を実行"
echo ""
