# Claude Code & Antigravity 自己進化システム

汎用Agent Team設定 + 自動学習・進化の仕組み

## ファイル構成

dotfiles/
├── .claude/
│   ├── CLAUDE.md              全プロジェクト共通の汎用ルール
│   ├── settings.json          Agent Team有効化・Hooks設定
│   ├── hooks/
│   │   └── session_logger.py  セッション終了時に自動実行
│   └── commands/
│       ├── learn.md           /learn（記録・進化を1コマンドで）
│       └── skill-save.md      /skill-save
└── .gemini/
    └── GEMINI.md              Antigravity用の汎用ルール

## 日々の使い方

作業終了後         → /learn
うまくいったとき   → /skill-save

## 新しいPCへのセットアップ

git clone https://github.com/amufaamo/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh

## 設計思想

自動収集（Hook）→ 自動提案（/learn）→ 人間が承認 → 自動適用

Claudeが提案し、あなたが判断する。
承認したものだけが蓄積され、システムが育っていく。
