# 汎用 Agent Configuration for Google Antigravity
# 場所: ~/.gemini/GEMINI.md（グローバル）

## ⚠️ このファイルについて
Google AntigravityにはClaude CodeのAgent Team機能がまだない。
project.mdを共有情報源として使い、Workflowで補完する。

## Step 1: タスク分析（作業開始前に必ず実行）

### 作業種別
- 実装系 / 調査系 / 執筆系 / 分析系 / レビュー系

### 分割できるか？
- 独立した関心事が3つ以上 → 複数Workspaceに分割
- 順番依存がある → Workflowで順番を定義
- 単純で小さい → 単一会話で処理

### 規模の判定
- 関心事が1つ（単一ファイル・単一テーマ） → 単独
- 関心事が2〜3つ、互いに独立 → 2〜3 Workspace
- 関心事が4つ以上、複数ドメイン → 4〜5 Workspace

## Step 2: project.mdルール

project.mdがある場合、必ず最初に読み込んでから作業を開始する。
タスク完了・重要な決定時に自動更新する。

構造（変更禁止）:
1. 目的と背景 (Why)
2. ゴールと最終成果物 (What)
3. ルール・制約・前提条件 (How)
4. 現在のタスクとスケジュール (Action)
5. 活動履歴・決定事項 (Log)

## Step 3: 共通ルール

- 作業開始時: Knowledge Itemsを確認 → project.mdを読む → 担当範囲を宣言
- 作業完了時: project.mdの「4.現在のタスク」と「5.活動履歴」を更新
- 完了報告: 「何を・どこで・どう確認したか」を必ず含める

## Step 4: 自己進化ルール

- /learn → セッション終了後に教訓を記録・提案
- /skill-save → うまくいったパターンをすぐSkillに保存
- GEMINI.mdの直接自動書き換えは禁止。必ず承認を経ること

## 【学習済みルール】
- [2026-03-19] WSLでGoogle Drive (G:) にアクセスできない（failed 19）場合は、`sudo mount -t drvfs G: /mnt/g` を実行して再マウントする
- [2026-03-19] Google Drive内への `git clone` はWSLからだとエラーになりやすいため、Windows側のPowerShellで行う
<!-- 形式: - [YYYY-MM-DD] ルール内容 -->
