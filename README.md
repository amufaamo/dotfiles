# Claude Code 自己進化システム

汎用Agent Team設定 + 自動学習・進化の仕組み

---

## ファイル構成

```
dotfiles/
└── .claude/
    ├── CLAUDE.md              ← 全プロジェクト共通の汎用ルール（自動進化）
    ├── settings.json          ← Agent Team有効化・Hooks設定
    ├── hooks/
    │   └── session_logger.py  ← セッション終了時に自動実行
    ├── commands/
    │   ├── learned.md         ← /learned コマンド
    │   ├── evolve.md          ← /evolve コマンド
    │   └── skill-save.md      ← /skill-save コマンド
    ├── skills/
    │   └── auto-evolved/      ← 自動保存されたSkillが蓄積される
    └── learning/
        ├── session_log.jsonl  ← セッションログ（自動）
        ├── insights.jsonl     ← 教訓ログ（/learnedで蓄積）
        └── applied.jsonl      ← 適用済み変更ログ（/evolveで記録）
```

---

## 日々の使い方

### セッション中・後
```
作業終了後 → /learned
```
→ Claudeがセッションを振り返り、失敗・成功パターンを記録
→ 軽微なルール追加をその場で提案・承認

### うまくいったらすぐ保存
```
良いパターンを見つけたとき → /skill-save
```
→ その場でSkillとして保存できる

### 週1回
```
/evolve
```
→ 蓄積したログを分析して改善提案を生成
→ 承認したものだけCLAUDE.mdとSkillに反映

---

## 新しいPCへのセットアップ

```bash
# GitHubからクローン
git clone https://github.com/あなたのアカウント/dotfiles.git ~/dotfiles

# セットアップ実行
bash ~/dotfiles/install.sh
```

---

## 設計思想

```
完全自動 ← ここはやらない（制御不能リスク）

自動収集（Hook）
    ↓
自動提案（/learned, /evolve）
    ↓
人間が承認         ← ここで必ず止まる
    ↓
自動適用（Claude Code がファイルを更新）
```

Claudeが提案し、あなたが判断する。
承認したものだけが蓄積され、システムが育っていく。
