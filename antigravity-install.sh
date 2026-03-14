#!/bin/bash
# antigravity-install.sh
# Antigravity設定のセットアップスクリプト
# dotfilesと共有の学習ログを使う

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

DOTFILES_DIR="$HOME/dotfiles"
GEMINI_DIR="$HOME/.gemini"
ANTIGRAVITY_DIR="$GEMINI_DIR/antigravity"
LEARNING_DIR="$HOME/.learning"

echo -e "${GREEN}=== Antigravity 自己進化システム セットアップ ===${NC}"
echo ""

# ディレクトリ作成
mkdir -p "$ANTIGRAVITY_DIR"/{workflows,skills/auto-evolved,rules}
mkdir -p "$LEARNING_DIR"

# シンボリックリンクを作成
echo "シンボリックリンクを作成中..."

# GEMINI.md（グローバル）
if [ -f "$DOTFILES_DIR/.gemini/GEMINI.md" ]; then
  ln -sf "$DOTFILES_DIR/.gemini/GEMINI.md" "$GEMINI_DIR/GEMINI.md"
  echo "  ✅ GEMINI.md"
fi

# Workflows（/learned /evolve /skill-save）
for f in "$DOTFILES_DIR/.gemini/antigravity/workflows/"*.md; do
  [ -f "$f" ] || continue
  fname=$(basename "$f")
  ln -sf "$f" "$ANTIGRAVITY_DIR/workflows/$fname"
  echo "  ✅ workflows/$fname"
done

# Rules
for f in "$DOTFILES_DIR/.gemini/antigravity/rules/"*.md; do
  [ -f "$f" ] || continue
  fname=$(basename "$f")
  ln -sf "$f" "$ANTIGRAVITY_DIR/rules/$fname"
  echo "  ✅ rules/$fname"
done

# 学習ログの初期化（Claude Codeと共有）
# Claude Codeの ~/.claude/learning/ と同じファイルをシンボリックリンク
CLAUDE_LEARNING="$HOME/.claude/learning"
if [ -d "$CLAUDE_LEARNING" ]; then
  echo ""
  echo -e "${YELLOW}Claude Codeの学習ログと共有します${NC}"
  for logfile in insights.jsonl applied.jsonl session_log.jsonl; do
    src="$CLAUDE_LEARNING/$logfile"
    dst="$LEARNING_DIR/$logfile"
    if [ -f "$src" ] && [ ! -L "$dst" ]; then
      ln -sf "$src" "$dst"
      echo "  ✅ $logfile (Claude Codeと共有)"
    elif [ ! -f "$dst" ] && [ ! -L "$dst" ]; then
      touch "$dst"
      echo "  ✅ $logfile を初期化"
    fi
  done
else
  for logfile in insights.jsonl applied.jsonl session_log.jsonl; do
    path="$LEARNING_DIR/$logfile"
    [ ! -f "$path" ] && touch "$path" && echo "  ✅ $logfile を初期化"
  done
fi

echo ""
echo -e "${GREEN}=== セットアップ完了 ===${NC}"
echo ""
echo "Antigravityで使えるワークフロー："
echo "  /learned    → セッション終了後に教訓を記録"
echo "  /evolve     → 週1回、GEMINI.mdとSkillを進化させる"
echo "  /skill-save → うまくいったパターンをすぐSkillに保存"
echo ""
echo -e "${YELLOW}Claude CodeとAntigravityで学習ログを共有しています${NC}"
echo "  ~/.learning/insights.jsonl"
