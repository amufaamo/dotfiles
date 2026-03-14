# Claude Code & Antigravity 自己進化システム

汎用Agent Team設定 + 自動学習・進化の仕組み

## ファイル構成

dotfiles/
├── .claude/
│   ├── CLAUDE.md              全プロジェクト共通の汎用ルール（自動進化）
│   ├── settings.json          Agent Team有効化・Hooks設定
│   ├── hooks/
│   │   └── session_logger.py  セッション終了時に自動ログ収集
│   └── commands/
│       ├── learn.md           /learn（記録・分析・進化提案を1コマンドで）
│       └── skill-save.md      /skill-save（成功パターンをすぐSkillに保存）
├── .gemini/
│   └── GEMINI.md              Antigravity用の汎用ルール
├── install.sh                 新しいPCのセットアップ
└── sync.sh                    GitHubへの同期

## 日々の使い方

作業終了後         → /learn
うまくいったとき   → /skill-save
複数PC間の同期     → bash ~/dotfiles/sync.sh

## 新しいPCへのセットアップ

git clone https://github.com/amufaamo/dotfiles.git ~/dotfiles
bash ~/dotfiles/install.sh

## 別のPCで最新を受け取る

cd ~/dotfiles && git pull

## 設計思想

自動収集（Hook）→ 自動提案（/learn）→ 人間が承認 → 自動適用 → GitHub同期

Claudeが提案し、あなたが判断する。
承認したものだけが蓄積され、使うほど賢くなっていく。
